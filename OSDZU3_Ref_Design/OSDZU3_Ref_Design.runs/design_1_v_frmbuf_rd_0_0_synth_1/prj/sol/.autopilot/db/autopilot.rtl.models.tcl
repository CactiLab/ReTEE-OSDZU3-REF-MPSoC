set SynModuleInfo {
  {SRCNAME AXIMMvideo2Bytes_Pipeline_VITIS_LOOP_515_1 MODELNAME AXIMMvideo2Bytes_Pipeline_VITIS_LOOP_515_1 RTLNAME design_1_v_frmbuf_rd_0_0_AXIMMvideo2Bytes_Pipeline_VITIS_LOOP_515_1
    SUBMODULES {
      {MODELNAME design_1_v_frmbuf_rd_0_0_flow_control_loop_pipe_sequential_init RTLNAME design_1_v_frmbuf_rd_0_0_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME design_1_v_frmbuf_rd_0_0_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME AXIMMvideo2Bytes MODELNAME AXIMMvideo2Bytes RTLNAME design_1_v_frmbuf_rd_0_0_AXIMMvideo2Bytes}
  {SRCNAME Bytes2MultiPixStream_Pipeline_VITIS_LOOP_1734_4 MODELNAME Bytes2MultiPixStream_Pipeline_VITIS_LOOP_1734_4 RTLNAME design_1_v_frmbuf_rd_0_0_Bytes2MultiPixStream_Pipeline_VITIS_LOOP_1734_4}
  {SRCNAME Bytes2MultiPixStream_Pipeline_VITIS_LOOP_1696_1 MODELNAME Bytes2MultiPixStream_Pipeline_VITIS_LOOP_1696_1 RTLNAME design_1_v_frmbuf_rd_0_0_Bytes2MultiPixStream_Pipeline_VITIS_LOOP_1696_1}
  {SRCNAME Bytes2MultiPixStream MODELNAME Bytes2MultiPixStream RTLNAME design_1_v_frmbuf_rd_0_0_Bytes2MultiPixStream}
  {SRCNAME {reg<unsigned short>} MODELNAME reg_unsigned_short_s RTLNAME design_1_v_frmbuf_rd_0_0_reg_unsigned_short_s}
  {SRCNAME MultiPixStream2AXIvideo_Pipeline_VITIS_LOOP_460_2 MODELNAME MultiPixStream2AXIvideo_Pipeline_VITIS_LOOP_460_2 RTLNAME design_1_v_frmbuf_rd_0_0_MultiPixStream2AXIvideo_Pipeline_VITIS_LOOP_460_2}
  {SRCNAME MultiPixStream2AXIvideo MODELNAME MultiPixStream2AXIvideo RTLNAME design_1_v_frmbuf_rd_0_0_MultiPixStream2AXIvideo}
  {SRCNAME FrmbufRdHlsDataFlow MODELNAME FrmbufRdHlsDataFlow RTLNAME design_1_v_frmbuf_rd_0_0_FrmbufRdHlsDataFlow
    SUBMODULES {
      {MODELNAME design_1_v_frmbuf_rd_0_0_fifo_w64_d961_B RTLNAME design_1_v_frmbuf_rd_0_0_fifo_w64_d961_B BINDTYPE storage TYPE fifo IMPL bram ALLOW_PRAGMA 1 INSTNAME bytePlanes_U}
      {MODELNAME design_1_v_frmbuf_rd_0_0_fifo_w32_d2_S RTLNAME design_1_v_frmbuf_rd_0_0_fifo_w32_d2_S BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME img_U}
      {MODELNAME design_1_v_frmbuf_rd_0_0_start_for_Bytes2MultiPixStream_U0 RTLNAME design_1_v_frmbuf_rd_0_0_start_for_Bytes2MultiPixStream_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_Bytes2MultiPixStream_U0_U}
      {MODELNAME design_1_v_frmbuf_rd_0_0_start_for_MultiPixStream2AXIvideo_U0 RTLNAME design_1_v_frmbuf_rd_0_0_start_for_MultiPixStream2AXIvideo_U0 BINDTYPE storage TYPE fifo IMPL srl ALLOW_PRAGMA 1 INSTNAME start_for_MultiPixStream2AXIvideo_U0_U}
    }
  }
  {SRCNAME v_frmbuf_rd MODELNAME v_frmbuf_rd RTLNAME design_1_v_frmbuf_rd_0_0_v_frmbuf_rd IS_TOP 1
    SUBMODULES {
      {MODELNAME design_1_v_frmbuf_rd_0_0_mul_15s_3ns_15_1_1 RTLNAME design_1_v_frmbuf_rd_0_0_mul_15s_3ns_15_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME design_1_v_frmbuf_rd_0_0_BYTES_PER_PIXEL_ROM_AUTO_1R RTLNAME design_1_v_frmbuf_rd_0_0_BYTES_PER_PIXEL_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME design_1_v_frmbuf_rd_0_0_MEMORY2LIVE_ROM_AUTO_1R RTLNAME design_1_v_frmbuf_rd_0_0_MEMORY2LIVE_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME design_1_v_frmbuf_rd_0_0_mm_video_m_axi RTLNAME design_1_v_frmbuf_rd_0_0_mm_video_m_axi BINDTYPE interface TYPE adapter IMPL m_axi}
      {MODELNAME design_1_v_frmbuf_rd_0_0_CTRL_s_axi RTLNAME design_1_v_frmbuf_rd_0_0_CTRL_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME design_1_v_frmbuf_rd_0_0_regslice_both RTLNAME design_1_v_frmbuf_rd_0_0_regslice_both BINDTYPE interface TYPE adapter IMPL reg_slice}
    }
  }
}
