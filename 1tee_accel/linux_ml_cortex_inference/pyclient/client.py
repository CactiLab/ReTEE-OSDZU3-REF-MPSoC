#!/usr/bin/env python3
"""
TCP client for linux_ml person detection stream.

Receives YUYV video frames with inference results from the FPGA board
and displays them with an overlay showing detection confidence.

Protocol: 4-byte header + 640x480 YUYV frame per packet
  header[0] = confidence (0-255)
  header[1] = person_score (int8)
  header[2] = no_person_score (int8)
  header[3] = reserved

Usage: python3 client.py <board_ip> [port]
"""

import sys
import socket
import struct
import numpy as np
import cv2

CAM_WIDTH = 640
CAM_HEIGHT = 480
HEADER_SZ = 4
FRAME_SZ = CAM_WIDTH * CAM_HEIGHT * 2  # YUYV = 2 bytes/pixel
PACKET_SZ = HEADER_SZ + FRAME_SZ


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
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <board_ip> [port]")
        sys.exit(1)

    host = sys.argv[1]
    port = int(sys.argv[2]) if len(sys.argv) > 2 else 8080

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
    print(f"Connecting to {host}:{port}...")
    sock.connect((host, port))
    print("Connected")

    fps_frames = 0
    fps_start = cv2.getTickCount()

    try:
        while True:
            pkt = recv_exact(sock, PACKET_SZ)
            if pkt is None:
                print("Connection closed")
                break

            # Parse header
            confidence = pkt[0]
            person_score = struct.unpack('b', bytes([pkt[1]]))[0]
            no_person_score = struct.unpack('b', bytes([pkt[2]]))[0]
            conf_pct = confidence * 100 // 255

            # Convert frame
            bgr = yuyv_to_bgr(pkt[HEADER_SZ:], CAM_WIDTH, CAM_HEIGHT)

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
