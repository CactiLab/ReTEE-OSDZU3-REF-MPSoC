#!/usr/bin/env python3
"""
TCP client for linux_ml person detection stream.

Receives YUYV video frames with inference results and per-frame attestation
fields from the FPGA board, and displays them with an overlay.

Packet layout (623724 bytes total; mirrors linux_ml_secure/src/main.c):
  off    sz       field
  0      1        confidence
  1      1        person_score (int8)
  2      1        no_person_score (int8)
  3      1        reserved
  4      8        challenge
  12     32       preExe_digest
  44     32       postExe_digest
  76     32       tag
  108    9216     preprocessed_input (96*96 int8, the bytes the TEE consumed)
  9324   614400   YUYV frame (display only)

This client only displays; verifying the tag/digests is the verifier's job
(see ATTEST_PLAN.md §6). Run client.py --print-att to dump the per-frame
digest/tag so they can be cross-checked manually.

Usage: python3 client.py <board_ip> [port] [--print-att]
"""

import sys
import socket
import struct
import numpy as np
import cv2

CAM_WIDTH = 640
CAM_HEIGHT = 480
FRAME_SZ = CAM_WIDTH * CAM_HEIGHT * 2  # YUYV = 2 bytes/pixel

ATT_DIGEST_SIZE = 32
ATT_CHALLENGE_SIZE = 8
MODEL_INPUT_SZ = 96 * 96

PKT_OFF_CONFIDENCE = 0
PKT_OFF_PSCORE     = 1
PKT_OFF_NPSCORE    = 2
PKT_OFF_RESERVED   = 3
PKT_OFF_CHALLENGE  = 4
PKT_OFF_PREEXE     = PKT_OFF_CHALLENGE + ATT_CHALLENGE_SIZE
PKT_OFF_POSTEXE    = PKT_OFF_PREEXE   + ATT_DIGEST_SIZE
PKT_OFF_TAG        = PKT_OFF_POSTEXE  + ATT_DIGEST_SIZE
PKT_OFF_INPUT      = PKT_OFF_TAG      + ATT_DIGEST_SIZE
PKT_OFF_YUYV       = PKT_OFF_INPUT    + MODEL_INPUT_SZ
PACKET_SZ          = PKT_OFF_YUYV     + FRAME_SZ


def recv_exact(sock, n):
    """Receive exactly n bytes from socket."""
    buf = bytearray()
    while len(buf) < n:
        chunk = sock.recv(n - len(buf))
        if not chunk:
            return None
        buf.extend(chunk)
    return bytes(buf)


def yuyv_to_bgr(data, w, h):
    """Convert YUYV raw bytes to BGR numpy array."""
    yuyv = np.frombuffer(data, dtype=np.uint8).reshape((h, w, 2))
    return cv2.cvtColor(yuyv, cv2.COLOR_YUV2BGR_YUYV)


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    flags = {a for a in sys.argv[1:] if a.startswith("--")}
    print_att = "--print-att" in flags

    if len(args) < 1:
        print(f"Usage: {sys.argv[0]} <board_ip> [port] [--print-att]")
        sys.exit(1)

    host = args[0]
    port = int(args[1]) if len(args) > 1 else 8080

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    print(f"Connecting to {host}:{port}...")
    sock.connect((host, port))
    print(f"Connected (packet size = {PACKET_SZ})")

    fps_frames = 0
    fps_start = cv2.getTickCount()

    try:
        while True:
            pkt = recv_exact(sock, PACKET_SZ)
            if pkt is None:
                print("Connection closed")
                break

            # Parse header
            confidence = pkt[PKT_OFF_CONFIDENCE]
            person_score = struct.unpack('b', bytes([pkt[PKT_OFF_PSCORE]]))[0]
            no_person_score = struct.unpack('b', bytes([pkt[PKT_OFF_NPSCORE]]))[0]
            conf_pct = confidence * 100 // 255

            if print_att:
                challenge = pkt[PKT_OFF_CHALLENGE:PKT_OFF_CHALLENGE+ATT_CHALLENGE_SIZE]
                preexe    = pkt[PKT_OFF_PREEXE:PKT_OFF_PREEXE+ATT_DIGEST_SIZE]
                postexe   = pkt[PKT_OFF_POSTEXE:PKT_OFF_POSTEXE+ATT_DIGEST_SIZE]
                tag       = pkt[PKT_OFF_TAG:PKT_OFF_TAG+ATT_DIGEST_SIZE]
                print(f"chal={challenge.hex()} pre={preexe.hex()} "
                      f"post={postexe.hex()} tag={tag.hex()}")

            # Convert frame (YUYV starts at PKT_OFF_YUYV, not 4)
            bgr = yuyv_to_bgr(pkt[PKT_OFF_YUYV:PKT_OFF_YUYV+FRAME_SZ],
                              CAM_WIDTH, CAM_HEIGHT)

            # FPS calculation
            fps_frames += 1
            elapsed = (cv2.getTickCount() - fps_start) / cv2.getTickFrequency()
            fps = fps_frames / elapsed if elapsed > 0 else 0
            if elapsed >= 2.0:
                fps_frames = 0
                fps_start = cv2.getTickCount()

            # Draw overlay
            detected = person_score > no_person_score
            color = (0, 255, 0) if detected else (0, 0, 255)
            label = "PERSON" if detected else "NO PERSON"

            # Background bar
            cv2.rectangle(bgr, (0, 0), (CAM_WIDTH, 40), (0, 0, 0), -1)

            # Confidence bar
            bar_w = int(conf_pct * 2.5)
            cv2.rectangle(bgr, (10, 8), (10 + bar_w, 32), color, -1)
            cv2.rectangle(bgr, (10, 8), (260, 32), color, 2)

            # Text
            cv2.putText(bgr, f"{label} {conf_pct}%", (270, 28),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.7, color, 2)
            cv2.putText(bgr, f"person:{person_score} noperson:{no_person_score}",
                        (10, 60), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1)
            cv2.putText(bgr, f"{fps:.1f} fps", (CAM_WIDTH - 120, 28),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 255, 255), 1)

            # Border flash on detection
            if detected and conf_pct > 60:
                cv2.rectangle(bgr, (0, 0), (CAM_WIDTH - 1, CAM_HEIGHT - 1), (0, 255, 0), 3)

            cv2.imshow("ML Person Detection", bgr)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

    except KeyboardInterrupt:
        pass
    finally:
        sock.close()
        cv2.destroyAllWindows()


if __name__ == "__main__":
    main()
