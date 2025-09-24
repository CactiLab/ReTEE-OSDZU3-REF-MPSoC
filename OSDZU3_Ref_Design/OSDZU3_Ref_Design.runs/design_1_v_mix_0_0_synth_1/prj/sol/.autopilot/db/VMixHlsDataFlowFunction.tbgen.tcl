set moduleName VMixHlsDataFlowFunction
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type dataflow
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 53
set C_modelName {VMixHlsDataFlowFunction}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ HwReg_width_val int 12 regular {ap_stable 0} }
	{ HwReg_height_val int 12 regular {ap_stable 0} }
	{ HwReg_background_Y_R_val12 int 8 regular {ap_stable 0} }
	{ HwReg_background_U_G_val13 int 8 regular {ap_stable 0} }
	{ HwReg_background_V_B_val14 int 8 regular {ap_stable 0} }
	{ HwReg_layerEnable_val16 int 3 regular {ap_stable 0} }
	{ HwReg_layerEnableFlag_0_val int 1 regular {ap_stable 0} }
	{ HwReg_layerEnableFlag_1_val int 1 regular {ap_stable 0} }
	{ HwReg_layerEnableFlag_2_val int 1 regular {ap_stable 0} }
	{ HwReg_layerAlpha_2_val17 int 9 regular {ap_stable 0} }
	{ HwReg_layerStartX_1_val18 int 16 regular {ap_stable 0} }
	{ HwReg_layerStartX_2_val19 int 16 regular {ap_stable 0} }
	{ HwReg_layerStartY_1_val20 int 16 regular {ap_stable 0} }
	{ HwReg_layerStartY_2_val21 int 16 regular {ap_stable 0} }
	{ HwReg_layerWidth_1_val int 16 regular {ap_stable 0} }
	{ HwReg_layerWidth_2_val int 16 regular {ap_stable 0} }
	{ HwReg_layerHeight_1_val int 16 regular {ap_stable 0} }
	{ HwReg_layerHeight_2_val int 16 regular {ap_stable 0} }
	{ HwReg_layerScaleFactor_1_val26 int 8 regular {ap_stable 0} }
	{ HwReg_layerScaleFactor_2_val27 int 8 regular {ap_stable 0} }
	{ s_axis_video_V_data_V int 24 regular {axi_s 0 volatile  { s_axis_video Data } }  }
	{ s_axis_video_V_keep_V int 3 regular {axi_s 0 volatile  { s_axis_video Keep } }  }
	{ s_axis_video_V_strb_V int 3 regular {axi_s 0 volatile  { s_axis_video Strb } }  }
	{ s_axis_video_V_user_V int 1 regular {axi_s 0 volatile  { s_axis_video User } }  }
	{ s_axis_video_V_last_V int 1 regular {axi_s 0 volatile  { s_axis_video Last } }  }
	{ s_axis_video_V_id_V int 1 regular {axi_s 0 volatile  { s_axis_video ID } }  }
	{ s_axis_video_V_dest_V int 1 regular {axi_s 0 volatile  { s_axis_video Dest } }  }
	{ s_axis_video1_V_data_V int 24 regular {axi_s 0 volatile  { s_axis_video1 Data } }  }
	{ s_axis_video1_V_keep_V int 3 regular {axi_s 0 volatile  { s_axis_video1 Keep } }  }
	{ s_axis_video1_V_strb_V int 3 regular {axi_s 0 volatile  { s_axis_video1 Strb } }  }
	{ s_axis_video1_V_user_V int 1 regular {axi_s 0 volatile  { s_axis_video1 User } }  }
	{ s_axis_video1_V_last_V int 1 regular {axi_s 0 volatile  { s_axis_video1 Last } }  }
	{ s_axis_video1_V_id_V int 1 regular {axi_s 0 volatile  { s_axis_video1 ID } }  }
	{ s_axis_video1_V_dest_V int 1 regular {axi_s 0 volatile  { s_axis_video1 Dest } }  }
	{ s_axis_video2_V_data_V int 24 regular {axi_s 0 volatile  { s_axis_video2 Data } }  }
	{ s_axis_video2_V_keep_V int 3 regular {axi_s 0 volatile  { s_axis_video2 Keep } }  }
	{ s_axis_video2_V_strb_V int 3 regular {axi_s 0 volatile  { s_axis_video2 Strb } }  }
	{ s_axis_video2_V_user_V int 1 regular {axi_s 0 volatile  { s_axis_video2 User } }  }
	{ s_axis_video2_V_last_V int 1 regular {axi_s 0 volatile  { s_axis_video2 Last } }  }
	{ s_axis_video2_V_id_V int 1 regular {axi_s 0 volatile  { s_axis_video2 ID } }  }
	{ s_axis_video2_V_dest_V int 1 regular {axi_s 0 volatile  { s_axis_video2 Dest } }  }
	{ m_axis_video_V_data_V int 24 regular {axi_s 1 volatile  { m_axis_video Data } }  }
	{ m_axis_video_V_keep_V int 3 regular {axi_s 1 volatile  { m_axis_video Keep } }  }
	{ m_axis_video_V_strb_V int 3 regular {axi_s 1 volatile  { m_axis_video Strb } }  }
	{ m_axis_video_V_user_V int 1 regular {axi_s 1 volatile  { m_axis_video User } }  }
	{ m_axis_video_V_last_V int 1 regular {axi_s 1 volatile  { m_axis_video Last } }  }
	{ m_axis_video_V_id_V int 1 regular {axi_s 1 volatile  { m_axis_video ID } }  }
	{ m_axis_video_V_dest_V int 1 regular {axi_s 1 volatile  { m_axis_video Dest } }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "HwReg_width_val", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_height_val", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_background_Y_R_val12", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_background_U_G_val13", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_background_V_B_val14", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerEnable_val16", "interface" : "wire", "bitwidth" : 3, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerEnableFlag_0_val", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerEnableFlag_1_val", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerEnableFlag_2_val", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerAlpha_2_val17", "interface" : "wire", "bitwidth" : 9, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerStartX_1_val18", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerStartX_2_val19", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerStartY_1_val20", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerStartY_2_val21", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerWidth_1_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerWidth_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerHeight_1_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerHeight_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerScaleFactor_1_val26", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerScaleFactor_2_val27", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video_V_data_V", "interface" : "axis", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video_V_keep_V", "interface" : "axis", "bitwidth" : 3, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video_V_strb_V", "interface" : "axis", "bitwidth" : 3, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video_V_user_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video_V_id_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video_V_dest_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video1_V_data_V", "interface" : "axis", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video1_V_keep_V", "interface" : "axis", "bitwidth" : 3, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video1_V_strb_V", "interface" : "axis", "bitwidth" : 3, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video1_V_user_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video1_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video1_V_id_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video1_V_dest_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video2_V_data_V", "interface" : "axis", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video2_V_keep_V", "interface" : "axis", "bitwidth" : 3, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video2_V_strb_V", "interface" : "axis", "bitwidth" : 3, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video2_V_user_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video2_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video2_V_id_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "s_axis_video2_V_dest_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "m_axis_video_V_data_V", "interface" : "axis", "bitwidth" : 24, "direction" : "WRITEONLY"} , 
 	{ "Name" : "m_axis_video_V_keep_V", "interface" : "axis", "bitwidth" : 3, "direction" : "WRITEONLY"} , 
 	{ "Name" : "m_axis_video_V_strb_V", "interface" : "axis", "bitwidth" : 3, "direction" : "WRITEONLY"} , 
 	{ "Name" : "m_axis_video_V_user_V", "interface" : "axis", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "m_axis_video_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "m_axis_video_V_id_V", "interface" : "axis", "bitwidth" : 1, "direction" : "WRITEONLY"} , 
 	{ "Name" : "m_axis_video_V_dest_V", "interface" : "axis", "bitwidth" : 1, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 83
set portList { 
	{ HwReg_width_val sc_in sc_lv 12 signal 0 } 
	{ HwReg_height_val sc_in sc_lv 12 signal 1 } 
	{ HwReg_background_Y_R_val12 sc_in sc_lv 8 signal 2 } 
	{ HwReg_background_U_G_val13 sc_in sc_lv 8 signal 3 } 
	{ HwReg_background_V_B_val14 sc_in sc_lv 8 signal 4 } 
	{ HwReg_layerEnable_val16 sc_in sc_lv 3 signal 5 } 
	{ HwReg_layerEnableFlag_0_val sc_in sc_lv 1 signal 6 } 
	{ HwReg_layerEnableFlag_1_val sc_in sc_lv 1 signal 7 } 
	{ HwReg_layerEnableFlag_2_val sc_in sc_lv 1 signal 8 } 
	{ HwReg_layerAlpha_2_val17 sc_in sc_lv 9 signal 9 } 
	{ HwReg_layerStartX_1_val18 sc_in sc_lv 16 signal 10 } 
	{ HwReg_layerStartX_2_val19 sc_in sc_lv 16 signal 11 } 
	{ HwReg_layerStartY_1_val20 sc_in sc_lv 16 signal 12 } 
	{ HwReg_layerStartY_2_val21 sc_in sc_lv 16 signal 13 } 
	{ HwReg_layerWidth_1_val sc_in sc_lv 16 signal 14 } 
	{ HwReg_layerWidth_2_val sc_in sc_lv 16 signal 15 } 
	{ HwReg_layerHeight_1_val sc_in sc_lv 16 signal 16 } 
	{ HwReg_layerHeight_2_val sc_in sc_lv 16 signal 17 } 
	{ HwReg_layerScaleFactor_1_val26 sc_in sc_lv 8 signal 18 } 
	{ HwReg_layerScaleFactor_2_val27 sc_in sc_lv 8 signal 19 } 
	{ s_axis_video_TDATA sc_in sc_lv 24 signal 20 } 
	{ s_axis_video_TKEEP sc_in sc_lv 3 signal 21 } 
	{ s_axis_video_TSTRB sc_in sc_lv 3 signal 22 } 
	{ s_axis_video_TUSER sc_in sc_lv 1 signal 23 } 
	{ s_axis_video_TLAST sc_in sc_lv 1 signal 24 } 
	{ s_axis_video_TID sc_in sc_lv 1 signal 25 } 
	{ s_axis_video_TDEST sc_in sc_lv 1 signal 26 } 
	{ s_axis_video1_TDATA sc_in sc_lv 24 signal 27 } 
	{ s_axis_video1_TKEEP sc_in sc_lv 3 signal 28 } 
	{ s_axis_video1_TSTRB sc_in sc_lv 3 signal 29 } 
	{ s_axis_video1_TUSER sc_in sc_lv 1 signal 30 } 
	{ s_axis_video1_TLAST sc_in sc_lv 1 signal 31 } 
	{ s_axis_video1_TID sc_in sc_lv 1 signal 32 } 
	{ s_axis_video1_TDEST sc_in sc_lv 1 signal 33 } 
	{ s_axis_video2_TDATA sc_in sc_lv 24 signal 34 } 
	{ s_axis_video2_TKEEP sc_in sc_lv 3 signal 35 } 
	{ s_axis_video2_TSTRB sc_in sc_lv 3 signal 36 } 
	{ s_axis_video2_TUSER sc_in sc_lv 1 signal 37 } 
	{ s_axis_video2_TLAST sc_in sc_lv 1 signal 38 } 
	{ s_axis_video2_TID sc_in sc_lv 1 signal 39 } 
	{ s_axis_video2_TDEST sc_in sc_lv 1 signal 40 } 
	{ m_axis_video_TDATA sc_out sc_lv 24 signal 41 } 
	{ m_axis_video_TKEEP sc_out sc_lv 3 signal 42 } 
	{ m_axis_video_TSTRB sc_out sc_lv 3 signal 43 } 
	{ m_axis_video_TUSER sc_out sc_lv 1 signal 44 } 
	{ m_axis_video_TLAST sc_out sc_lv 1 signal 45 } 
	{ m_axis_video_TID sc_out sc_lv 1 signal 46 } 
	{ m_axis_video_TDEST sc_out sc_lv 1 signal 47 } 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ s_axis_video_TVALID sc_in sc_logic 1 invld 26 } 
	{ s_axis_video_TREADY sc_out sc_logic 1 inacc 26 } 
	{ HwReg_height_val_ap_vld sc_in sc_logic 1 invld 1 } 
	{ HwReg_width_val_ap_vld sc_in sc_logic 1 invld 0 } 
	{ HwReg_layerEnableFlag_0_val_ap_vld sc_in sc_logic 1 invld 6 } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ s_axis_video1_TVALID sc_in sc_logic 1 invld 33 } 
	{ s_axis_video1_TREADY sc_out sc_logic 1 inacc 33 } 
	{ HwReg_layerHeight_1_val_ap_vld sc_in sc_logic 1 invld 16 } 
	{ HwReg_layerWidth_1_val_ap_vld sc_in sc_logic 1 invld 14 } 
	{ HwReg_layerEnableFlag_1_val_ap_vld sc_in sc_logic 1 invld 7 } 
	{ HwReg_background_Y_R_val12_ap_vld sc_in sc_logic 1 invld 2 } 
	{ HwReg_background_U_G_val13_ap_vld sc_in sc_logic 1 invld 3 } 
	{ HwReg_background_V_B_val14_ap_vld sc_in sc_logic 1 invld 4 } 
	{ HwReg_layerEnable_val16_ap_vld sc_in sc_logic 1 invld 5 } 
	{ HwReg_layerStartX_1_val18_ap_vld sc_in sc_logic 1 invld 10 } 
	{ HwReg_layerStartY_1_val20_ap_vld sc_in sc_logic 1 invld 12 } 
	{ HwReg_layerScaleFactor_1_val26_ap_vld sc_in sc_logic 1 invld 18 } 
	{ s_axis_video2_TVALID sc_in sc_logic 1 invld 40 } 
	{ s_axis_video2_TREADY sc_out sc_logic 1 inacc 40 } 
	{ HwReg_layerHeight_2_val_ap_vld sc_in sc_logic 1 invld 17 } 
	{ HwReg_layerWidth_2_val_ap_vld sc_in sc_logic 1 invld 15 } 
	{ HwReg_layerEnableFlag_2_val_ap_vld sc_in sc_logic 1 invld 8 } 
	{ HwReg_layerAlpha_2_val17_ap_vld sc_in sc_logic 1 invld 9 } 
	{ HwReg_layerStartX_2_val19_ap_vld sc_in sc_logic 1 invld 11 } 
	{ HwReg_layerStartY_2_val21_ap_vld sc_in sc_logic 1 invld 13 } 
	{ HwReg_layerScaleFactor_2_val27_ap_vld sc_in sc_logic 1 invld 19 } 
	{ m_axis_video_TVALID sc_out sc_logic 1 outvld 47 } 
	{ m_axis_video_TREADY sc_in sc_logic 1 outacc 47 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
}
set NewPortList {[ 
	{ "name": "HwReg_width_val", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "HwReg_width_val", "role": "default" }} , 
 	{ "name": "HwReg_height_val", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "HwReg_height_val", "role": "default" }} , 
 	{ "name": "HwReg_background_Y_R_val12", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_background_Y_R_val12", "role": "default" }} , 
 	{ "name": "HwReg_background_U_G_val13", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_background_U_G_val13", "role": "default" }} , 
 	{ "name": "HwReg_background_V_B_val14", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_background_V_B_val14", "role": "default" }} , 
 	{ "name": "HwReg_layerEnable_val16", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "HwReg_layerEnable_val16", "role": "default" }} , 
 	{ "name": "HwReg_layerEnableFlag_0_val", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HwReg_layerEnableFlag_0_val", "role": "default" }} , 
 	{ "name": "HwReg_layerEnableFlag_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HwReg_layerEnableFlag_1_val", "role": "default" }} , 
 	{ "name": "HwReg_layerEnableFlag_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HwReg_layerEnableFlag_2_val", "role": "default" }} , 
 	{ "name": "HwReg_layerAlpha_2_val17", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "HwReg_layerAlpha_2_val17", "role": "default" }} , 
 	{ "name": "HwReg_layerStartX_1_val18", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerStartX_1_val18", "role": "default" }} , 
 	{ "name": "HwReg_layerStartX_2_val19", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerStartX_2_val19", "role": "default" }} , 
 	{ "name": "HwReg_layerStartY_1_val20", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerStartY_1_val20", "role": "default" }} , 
 	{ "name": "HwReg_layerStartY_2_val21", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerStartY_2_val21", "role": "default" }} , 
 	{ "name": "HwReg_layerWidth_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerWidth_1_val", "role": "default" }} , 
 	{ "name": "HwReg_layerWidth_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerWidth_2_val", "role": "default" }} , 
 	{ "name": "HwReg_layerHeight_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerHeight_1_val", "role": "default" }} , 
 	{ "name": "HwReg_layerHeight_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerHeight_2_val", "role": "default" }} , 
 	{ "name": "HwReg_layerScaleFactor_1_val26", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_layerScaleFactor_1_val26", "role": "default" }} , 
 	{ "name": "HwReg_layerScaleFactor_2_val27", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_layerScaleFactor_2_val27", "role": "default" }} , 
 	{ "name": "s_axis_video_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "s_axis_video_V_data_V", "role": "default" }} , 
 	{ "name": "s_axis_video_TKEEP", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "s_axis_video_V_keep_V", "role": "default" }} , 
 	{ "name": "s_axis_video_TSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "s_axis_video_V_strb_V", "role": "default" }} , 
 	{ "name": "s_axis_video_TUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video_V_user_V", "role": "default" }} , 
 	{ "name": "s_axis_video_TLAST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video_V_last_V", "role": "default" }} , 
 	{ "name": "s_axis_video_TID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video_V_id_V", "role": "default" }} , 
 	{ "name": "s_axis_video_TDEST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video_V_dest_V", "role": "default" }} , 
 	{ "name": "s_axis_video1_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "s_axis_video1_V_data_V", "role": "default" }} , 
 	{ "name": "s_axis_video1_TKEEP", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "s_axis_video1_V_keep_V", "role": "default" }} , 
 	{ "name": "s_axis_video1_TSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "s_axis_video1_V_strb_V", "role": "default" }} , 
 	{ "name": "s_axis_video1_TUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video1_V_user_V", "role": "default" }} , 
 	{ "name": "s_axis_video1_TLAST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video1_V_last_V", "role": "default" }} , 
 	{ "name": "s_axis_video1_TID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video1_V_id_V", "role": "default" }} , 
 	{ "name": "s_axis_video1_TDEST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video1_V_dest_V", "role": "default" }} , 
 	{ "name": "s_axis_video2_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "s_axis_video2_V_data_V", "role": "default" }} , 
 	{ "name": "s_axis_video2_TKEEP", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "s_axis_video2_V_keep_V", "role": "default" }} , 
 	{ "name": "s_axis_video2_TSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "s_axis_video2_V_strb_V", "role": "default" }} , 
 	{ "name": "s_axis_video2_TUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video2_V_user_V", "role": "default" }} , 
 	{ "name": "s_axis_video2_TLAST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video2_V_last_V", "role": "default" }} , 
 	{ "name": "s_axis_video2_TID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video2_V_id_V", "role": "default" }} , 
 	{ "name": "s_axis_video2_TDEST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "s_axis_video2_V_dest_V", "role": "default" }} , 
 	{ "name": "m_axis_video_TDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "m_axis_video_V_data_V", "role": "default" }} , 
 	{ "name": "m_axis_video_TKEEP", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "m_axis_video_V_keep_V", "role": "default" }} , 
 	{ "name": "m_axis_video_TSTRB", "direction": "out", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "m_axis_video_V_strb_V", "role": "default" }} , 
 	{ "name": "m_axis_video_TUSER", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "m_axis_video_V_user_V", "role": "default" }} , 
 	{ "name": "m_axis_video_TLAST", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "m_axis_video_V_last_V", "role": "default" }} , 
 	{ "name": "m_axis_video_TID", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "m_axis_video_V_id_V", "role": "default" }} , 
 	{ "name": "m_axis_video_TDEST", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "m_axis_video_V_dest_V", "role": "default" }} , 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "s_axis_video_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "s_axis_video_V_dest_V", "role": "default" }} , 
 	{ "name": "s_axis_video_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "s_axis_video_V_dest_V", "role": "default" }} , 
 	{ "name": "HwReg_height_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_height_val", "role": "ap_vld" }} , 
 	{ "name": "HwReg_width_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_width_val", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerEnableFlag_0_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerEnableFlag_0_val", "role": "ap_vld" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "s_axis_video1_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "s_axis_video1_V_dest_V", "role": "default" }} , 
 	{ "name": "s_axis_video1_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "s_axis_video1_V_dest_V", "role": "default" }} , 
 	{ "name": "HwReg_layerHeight_1_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerHeight_1_val", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerWidth_1_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerWidth_1_val", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerEnableFlag_1_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerEnableFlag_1_val", "role": "ap_vld" }} , 
 	{ "name": "HwReg_background_Y_R_val12_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_background_Y_R_val12", "role": "ap_vld" }} , 
 	{ "name": "HwReg_background_U_G_val13_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_background_U_G_val13", "role": "ap_vld" }} , 
 	{ "name": "HwReg_background_V_B_val14_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_background_V_B_val14", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerEnable_val16_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerEnable_val16", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerStartX_1_val18_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerStartX_1_val18", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerStartY_1_val20_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerStartY_1_val20", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerScaleFactor_1_val26_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerScaleFactor_1_val26", "role": "ap_vld" }} , 
 	{ "name": "s_axis_video2_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "s_axis_video2_V_dest_V", "role": "default" }} , 
 	{ "name": "s_axis_video2_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "s_axis_video2_V_dest_V", "role": "default" }} , 
 	{ "name": "HwReg_layerHeight_2_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerHeight_2_val", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerWidth_2_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerWidth_2_val", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerEnableFlag_2_val_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerEnableFlag_2_val", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerAlpha_2_val17_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerAlpha_2_val17", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerStartX_2_val19_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerStartX_2_val19", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerStartY_2_val21_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerStartY_2_val21", "role": "ap_vld" }} , 
 	{ "name": "HwReg_layerScaleFactor_2_val27_ap_vld", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "HwReg_layerScaleFactor_2_val27", "role": "ap_vld" }} , 
 	{ "name": "m_axis_video_TVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "m_axis_video_V_dest_V", "role": "default" }} , 
 	{ "name": "m_axis_video_TREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "outacc", "bundle":{"name": "m_axis_video_V_dest_V", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	VMixHlsDataFlowFunction {
		HwReg_width_val {Type I LastRead 0 FirstWrite -1}
		HwReg_height_val {Type I LastRead 0 FirstWrite -1}
		HwReg_background_Y_R_val12 {Type I LastRead 10 FirstWrite -1}
		HwReg_background_U_G_val13 {Type I LastRead 10 FirstWrite -1}
		HwReg_background_V_B_val14 {Type I LastRead 10 FirstWrite -1}
		HwReg_layerEnable_val16 {Type I LastRead 10 FirstWrite -1}
		HwReg_layerEnableFlag_0_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerAlpha_2_val17 {Type I LastRead 12 FirstWrite -1}
		HwReg_layerStartX_1_val18 {Type I LastRead 10 FirstWrite -1}
		HwReg_layerStartX_2_val19 {Type I LastRead 12 FirstWrite -1}
		HwReg_layerStartY_1_val20 {Type I LastRead 10 FirstWrite -1}
		HwReg_layerStartY_2_val21 {Type I LastRead 12 FirstWrite -1}
		HwReg_layerWidth_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerHeight_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerHeight_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerScaleFactor_1_val26 {Type I LastRead 10 FirstWrite -1}
		HwReg_layerScaleFactor_2_val27 {Type I LastRead 12 FirstWrite -1}
		s_axis_video_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_dest_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_dest_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_dest_V {Type I LastRead 1 FirstWrite -1}
		m_axis_video_V_data_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_keep_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_strb_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_user_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_last_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_id_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_dest_V {Type O LastRead -1 FirstWrite 1}}
	AXIvideo2MultiPixStream_1 {
		s_axis_video_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_dest_V {Type I LastRead 1 FirstWrite -1}
		srcLayer0 {Type O LastRead -1 FirstWrite 2}
		Height {Type I LastRead 0 FirstWrite -1}
		WidthIn {Type I LastRead 0 FirstWrite -1}
		layerEnableFlag {Type I LastRead 1 FirstWrite -1}}
	AXIvideo2MultiPixStream_1_Pipeline_loop_wait_for_start {
		s_axis_video_V_data_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_keep_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_strb_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_user_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_last_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_id_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_dest_V {Type I LastRead 0 FirstWrite -1}
		axi_data_out {Type O LastRead -1 FirstWrite 0}
		axi_last_out {Type O LastRead -1 FirstWrite 0}}
	AXIvideo2MultiPixStream_1_Pipeline_loop_width {
		sof_7 {Type I LastRead 0 FirstWrite -1}
		axi_last_12 {Type I LastRead 0 FirstWrite -1}
		axi_data_10 {Type I LastRead 0 FirstWrite -1}
		cols {Type I LastRead 0 FirstWrite -1}
		srcLayer0 {Type O LastRead -1 FirstWrite 2}
		s_axis_video_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video_V_dest_V {Type I LastRead 1 FirstWrite -1}
		eol_out {Type O LastRead -1 FirstWrite 1}
		axi_data_11_out {Type O LastRead -1 FirstWrite 1}}
	AXIvideo2MultiPixStream_1_Pipeline_loop_wait_for_eol {
		axi_data_11_reload {Type I LastRead 0 FirstWrite -1}
		select_ln3436 {Type I LastRead 0 FirstWrite -1}
		eol_reload {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_data_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_keep_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_strb_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_user_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_last_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_id_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video_V_dest_V {Type I LastRead 0 FirstWrite -1}
		axi_data_4_out {Type O LastRead -1 FirstWrite 0}
		axi_last_4_out {Type O LastRead -1 FirstWrite 0}}
	reg_unsigned_short_1 {
		d {Type I LastRead 1 FirstWrite -1}}
	reg_unsigned_short_1 {
		d {Type I LastRead 1 FirstWrite -1}}
	v_mix_420_to_422_false_2 {
		srcLayer0 {Type I LastRead 1 FirstWrite -1}
		height {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		layerEnableFlag {Type I LastRead 0 FirstWrite -1}
		srcLayer0Yuv422 {Type O LastRead -1 FirstWrite 1}}
	v_mix_420_to_422_false_2_Pipeline_VITIS_LOOP_76_2 {
		width {Type I LastRead 0 FirstWrite -1}
		srcLayer0 {Type I LastRead 1 FirstWrite -1}
		srcLayer0Yuv422 {Type O LastRead -1 FirstWrite 1}}
	v_mix_422_to_444_false_3 {
		srcLayer0Yuv422 {Type I LastRead 1 FirstWrite -1}
		height {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		layerEnableFlag {Type I LastRead 0 FirstWrite -1}
		srcLayer0Yuv {Type O LastRead -1 FirstWrite 1}}
	v_mix_422_to_444_false_3_Pipeline_VITIS_LOOP_105_2 {
		width {Type I LastRead 0 FirstWrite -1}
		srcLayer0Yuv422 {Type I LastRead 1 FirstWrite -1}
		srcLayer0Yuv {Type O LastRead -1 FirstWrite 1}}
	v_mix_yuv2rgb_false_4 {
		srcLayer0Yuv {Type I LastRead 1 FirstWrite -1}
		height {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		layerEnableFlag {Type I LastRead 0 FirstWrite -1}
		outLayer0 {Type O LastRead -1 FirstWrite 1}}
	v_mix_yuv2rgb_false_4_Pipeline_VITIS_LOOP_897_2 {
		width {Type I LastRead 0 FirstWrite -1}
		srcLayer0Yuv {Type I LastRead 1 FirstWrite -1}
		outLayer0 {Type O LastRead -1 FirstWrite 1}}
	AXIvideo2MultiPixStream_5 {
		s_axis_video1_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_dest_V {Type I LastRead 1 FirstWrite -1}
		srcLayer1 {Type O LastRead -1 FirstWrite 2}
		HwReg_layerHeight_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_1_val {Type I LastRead 1 FirstWrite -1}}
	AXIvideo2MultiPixStream_5_Pipeline_loop_wait_for_start {
		s_axis_video1_V_data_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_keep_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_strb_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_user_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_last_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_id_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_dest_V {Type I LastRead 0 FirstWrite -1}
		axi_data_i_out {Type O LastRead -1 FirstWrite 0}
		axi_last_i_out {Type O LastRead -1 FirstWrite 0}}
	AXIvideo2MultiPixStream_5_Pipeline_loop_width {
		sof_4_i {Type I LastRead 0 FirstWrite -1}
		axi_last_2_i {Type I LastRead 0 FirstWrite -1}
		axi_data_2_i {Type I LastRead 0 FirstWrite -1}
		cols_i {Type I LastRead 0 FirstWrite -1}
		srcLayer1 {Type O LastRead -1 FirstWrite 2}
		s_axis_video1_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video1_V_dest_V {Type I LastRead 1 FirstWrite -1}
		eol_i_out {Type O LastRead -1 FirstWrite 1}
		axi_data_3_i_out {Type O LastRead -1 FirstWrite 1}}
	AXIvideo2MultiPixStream_5_Pipeline_loop_wait_for_eol {
		axi_data_3_i_reload {Type I LastRead 0 FirstWrite -1}
		select_ln3436_i {Type I LastRead 0 FirstWrite -1}
		eol_i_reload {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_data_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_keep_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_strb_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_user_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_last_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_id_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video1_V_dest_V {Type I LastRead 0 FirstWrite -1}
		axi_data_4_i_out {Type O LastRead -1 FirstWrite 0}
		axi_last_4_i_out {Type O LastRead -1 FirstWrite 0}}
	reg_unsigned_short_s {
		d {Type I LastRead 1 FirstWrite -1}}
	reg_unsigned_short_s {
		d {Type I LastRead 1 FirstWrite -1}}
	v_mix_420_to_422_false_6 {
		srcLayer1 {Type I LastRead 1 FirstWrite -1}
		HwReg_layerHeight_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_1_val {Type I LastRead 0 FirstWrite -1}
		srcLayer1Yuv422 {Type O LastRead -1 FirstWrite 1}}
	v_mix_420_to_422_false_6_Pipeline_VITIS_LOOP_76_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		srcLayer1 {Type I LastRead 1 FirstWrite -1}
		srcLayer1Yuv422 {Type O LastRead -1 FirstWrite 1}}
	v_mix_422_to_444_true_s {
		srcLayer1Yuv422 {Type I LastRead 1 FirstWrite -1}
		height {Type I LastRead 0 FirstWrite -1}
		width {Type I LastRead 0 FirstWrite -1}
		layerEnableFlag {Type I LastRead 0 FirstWrite -1}
		srcLayer1Yuv {Type O LastRead -1 FirstWrite 3}}
	v_mix_422_to_444_true_Pipeline_VITIS_LOOP_161_2 {
		p_0_0_0206358_lcssa364426 {Type I LastRead 0 FirstWrite -1}
		p_0_0_0_0_0207_4_lcssa423 {Type I LastRead 0 FirstWrite -1}
		p_0_0_0_0_0207_3_lcssa420 {Type I LastRead 0 FirstWrite -1}
		p_0_0_0_0_0207_2_lcssa417 {Type I LastRead 0 FirstWrite -1}
		p_0_0_0206358_lcssa409 {Type I LastRead 0 FirstWrite -1}
		loopWidth {Type I LastRead 0 FirstWrite -1}
		srcLayer1Yuv {Type O LastRead -1 FirstWrite 3}
		width {Type I LastRead 0 FirstWrite -1}
		srcLayer1Yuv422 {Type I LastRead 1 FirstWrite -1}
		p_0_0_0199355390_out {Type IO LastRead 2 FirstWrite 2}
		p_0_0_0200353387_out {Type IO LastRead 2 FirstWrite 2}
		p_0_0_0_0_0_2384_out {Type IO LastRead 2 FirstWrite 2}
		p_0_0_0_0_0205_2381_out {Type IO LastRead 2 FirstWrite 2}
		p_0_0_0_0_0_1374_out {Type IO LastRead 2 FirstWrite 2}
		p_0_0_0_0_0205_1367_out {Type IO LastRead 2 FirstWrite 2}
		p_0_0_0206358363_out {Type O LastRead -1 FirstWrite 2}
		p_0_0_0_0_0207_4362_out {Type O LastRead -1 FirstWrite 2}
		p_0_0_0_0_0207_3361_out {Type O LastRead -1 FirstWrite 2}
		p_0_0_0_0_0207_2360_out {Type O LastRead -1 FirstWrite 2}
		p_0_0_0_0_0207_1359_out {Type IO LastRead 3 FirstWrite 3}
		p_0_0_0199354_out {Type IO LastRead 2 FirstWrite 1}
		p_0_0_0200352_out {Type IO LastRead 2 FirstWrite 1}}
	v_mix_yuv2rgb_true_s {
		srcLayer1Yuv {Type I LastRead 1 FirstWrite -1}
		HwReg_layerHeight_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_1_val {Type I LastRead 0 FirstWrite -1}
		srcLayer1Rgb {Type O LastRead -1 FirstWrite 5}}
	v_mix_yuv2rgb_true_Pipeline_VITIS_LOOP_941_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		srcLayer1Yuv {Type I LastRead 1 FirstWrite -1}
		srcLayer1Rgb {Type O LastRead -1 FirstWrite 5}}
	v_mix_upsample_false_7 {
		srcLayer1Rgb {Type I LastRead 1 FirstWrite -1}
		HwReg_layerHeight_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_1_val {Type I LastRead 0 FirstWrite -1}
		srcLayer1x {Type O LastRead -1 FirstWrite 1}}
	v_mix_upsample_false_7_Pipeline_VITIS_LOOP_107_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		srcLayer1Rgb {Type I LastRead 1 FirstWrite -1}
		srcLayer1x {Type O LastRead -1 FirstWrite 1}}
	v_mix_core_alpha_false_false_s {
		outLayer0 {Type I LastRead 1 FirstWrite -1}
		srcLayer1x {Type I LastRead 1 FirstWrite -1}
		HwReg_width_val {Type I LastRead 0 FirstWrite -1}
		HwReg_height_val {Type I LastRead 0 FirstWrite -1}
		HwReg_background_Y_R_val12 {Type I LastRead 0 FirstWrite -1}
		HwReg_background_U_G_val13 {Type I LastRead 0 FirstWrite -1}
		HwReg_background_V_B_val14 {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnable_val16 {Type I LastRead 0 FirstWrite -1}
		HwReg_layerStartX_1_val18 {Type I LastRead 0 FirstWrite -1}
		HwReg_layerStartY_1_val20 {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerHeight_1_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerScaleFactor_1_val26 {Type I LastRead 0 FirstWrite -1}
		outLayer1 {Type O LastRead -1 FirstWrite 2}}
	v_mix_core_alpha_false_false_Pipeline_VITIS_LOOP_465_3 {
		HwReg_width_val {Type I LastRead 0 FirstWrite -1}
		outLayer1 {Type O LastRead -1 FirstWrite 2}
		srcLayer1x {Type I LastRead 1 FirstWrite -1}
		HwReg_background_Y_R_val12 {Type I LastRead 0 FirstWrite -1}
		HwReg_background_U_G_val13 {Type I LastRead 0 FirstWrite -1}
		HwReg_background_V_B_val14 {Type I LastRead 0 FirstWrite -1}
		HwReg_layerStartX_1_val18 {Type I LastRead 0 FirstWrite -1}
		add71_i_i {Type I LastRead 0 FirstWrite -1}
		cmp61_i_i {Type I LastRead 0 FirstWrite -1}
		rev5 {Type I LastRead 0 FirstWrite -1}
		empty_65 {Type I LastRead 0 FirstWrite -1}
		empty {Type I LastRead 0 FirstWrite -1}
		outLayer0 {Type I LastRead 1 FirstWrite -1}}
	AXIvideo2MultiPixStream {
		s_axis_video2_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_dest_V {Type I LastRead 1 FirstWrite -1}
		srcLayer2 {Type O LastRead -1 FirstWrite 2}
		HwReg_layerHeight_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_2_val {Type I LastRead 1 FirstWrite -1}}
	AXIvideo2MultiPixStream_Pipeline_loop_wait_for_start {
		s_axis_video2_V_data_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_keep_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_strb_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_user_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_last_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_id_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_dest_V {Type I LastRead 0 FirstWrite -1}
		axi_data_i_out {Type O LastRead -1 FirstWrite 0}
		axi_last_i_out {Type O LastRead -1 FirstWrite 0}}
	AXIvideo2MultiPixStream_Pipeline_loop_width {
		sof_10_i {Type I LastRead 0 FirstWrite -1}
		axi_last_21_i {Type I LastRead 0 FirstWrite -1}
		axi_data_17_i {Type I LastRead 0 FirstWrite -1}
		cols_i {Type I LastRead 0 FirstWrite -1}
		srcLayer2 {Type O LastRead -1 FirstWrite 2}
		s_axis_video2_V_data_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_keep_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_strb_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_user_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_last_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_id_V {Type I LastRead 1 FirstWrite -1}
		s_axis_video2_V_dest_V {Type I LastRead 1 FirstWrite -1}
		eol_i_out {Type O LastRead -1 FirstWrite 1}
		axi_data_18_i_out {Type O LastRead -1 FirstWrite 1}}
	AXIvideo2MultiPixStream_Pipeline_loop_wait_for_eol {
		axi_data_18_i_reload {Type I LastRead 0 FirstWrite -1}
		select_ln3436_i {Type I LastRead 0 FirstWrite -1}
		eol_i_reload {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_data_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_keep_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_strb_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_user_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_last_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_id_V {Type I LastRead 0 FirstWrite -1}
		s_axis_video2_V_dest_V {Type I LastRead 0 FirstWrite -1}
		axi_data_19_i_out {Type O LastRead -1 FirstWrite 0}
		axi_last_23_i_out {Type O LastRead -1 FirstWrite 0}}
	reg_unsigned_short_s {
		d {Type I LastRead 1 FirstWrite -1}}
	reg_unsigned_short_s {
		d {Type I LastRead 1 FirstWrite -1}}
	v_mix_420_to_422_false_s {
		srcLayer2 {Type I LastRead 1 FirstWrite -1}
		HwReg_layerHeight_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_2_val {Type I LastRead 0 FirstWrite -1}
		srcLayer2Yuv422 {Type O LastRead -1 FirstWrite 1}}
	v_mix_420_to_422_false_Pipeline_VITIS_LOOP_76_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		srcLayer2 {Type I LastRead 1 FirstWrite -1}
		srcLayer2Yuv422 {Type O LastRead -1 FirstWrite 1}}
	v_mix_422_to_444_false_s {
		srcLayer2Yuv422 {Type I LastRead 1 FirstWrite -1}
		HwReg_layerHeight_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_2_val {Type I LastRead 0 FirstWrite -1}
		srcLayer2Yuv {Type O LastRead -1 FirstWrite 1}}
	v_mix_422_to_444_false_Pipeline_VITIS_LOOP_105_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		srcLayer2Yuv422 {Type I LastRead 1 FirstWrite -1}
		srcLayer2Yuv {Type O LastRead -1 FirstWrite 1}}
	v_mix_yuv2rgb_false_s {
		srcLayer2Yuv {Type I LastRead 1 FirstWrite -1}
		HwReg_layerHeight_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_2_val {Type I LastRead 0 FirstWrite -1}
		srcLayer2Rgb {Type O LastRead -1 FirstWrite 1}}
	v_mix_yuv2rgb_false_Pipeline_VITIS_LOOP_897_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		srcLayer2Yuv {Type I LastRead 1 FirstWrite -1}
		srcLayer2Rgb {Type O LastRead -1 FirstWrite 1}}
	v_mix_upsample_false_s {
		srcLayer2Rgb {Type I LastRead 1 FirstWrite -1}
		HwReg_layerHeight_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_2_val {Type I LastRead 0 FirstWrite -1}
		srcLayer2x {Type O LastRead -1 FirstWrite 1}}
	v_mix_upsample_false_Pipeline_VITIS_LOOP_107_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		srcLayer2Rgb {Type I LastRead 1 FirstWrite -1}
		srcLayer2x {Type O LastRead -1 FirstWrite 1}}
	v_mix_core_alpha_true_false_s {
		outLayer1 {Type I LastRead 1 FirstWrite -1}
		srcLayer2x {Type I LastRead 1 FirstWrite -1}
		hwReg_width_val {Type I LastRead 1 FirstWrite -1}
		hwReg_height_val {Type I LastRead 1 FirstWrite -1}
		hwReg_layerEnable_val {Type I LastRead 1 FirstWrite -1}
		hwReg_layerAlpha_2_val {Type I LastRead 0 FirstWrite -1}
		hwReg_layerStartX_2_val {Type I LastRead 1 FirstWrite -1}
		hwReg_layerStartY_2_val {Type I LastRead 1 FirstWrite -1}
		hwReg_layerWidth_2_val {Type I LastRead 1 FirstWrite -1}
		hwReg_layerHeight_2_val {Type I LastRead 1 FirstWrite -1}
		hwReg_layerScaleFactor_2_val {Type I LastRead 1 FirstWrite -1}
		outLayer2 {Type O LastRead -1 FirstWrite 5}}
	v_mix_core_alpha_true_false_Pipeline_VITIS_LOOP_395_3 {
		hwReg_width_val {Type I LastRead 0 FirstWrite -1}
		alpha {Type I LastRead 0 FirstWrite -1}
		outLayer2 {Type O LastRead -1 FirstWrite 5}
		srcLayer2x {Type I LastRead 1 FirstWrite -1}
		outLayer1 {Type I LastRead 1 FirstWrite -1}
		hwReg_layerStartX_2_val {Type I LastRead 0 FirstWrite -1}
		add75 {Type I LastRead 0 FirstWrite -1}
		cmp65 {Type I LastRead 0 FirstWrite -1}
		rev7 {Type I LastRead 0 FirstWrite -1}
		empty {Type I LastRead 0 FirstWrite -1}
		p_out {Type IO LastRead 2 FirstWrite 1}
		p_out1 {Type IO LastRead 2 FirstWrite 1}
		p_out2 {Type IO LastRead 2 FirstWrite 1}}
	reg_unsigned_short_12 {
		d {Type I LastRead 1 FirstWrite -1}}
	v_mix_rgb2yuv_false_s {
		outLayer2 {Type I LastRead 1 FirstWrite -1}
		height_val {Type I LastRead 0 FirstWrite -1}
		width_val {Type I LastRead 0 FirstWrite -1}
		outYuv {Type O LastRead -1 FirstWrite 1}}
	v_mix_rgb2yuv_false_Pipeline_VITIS_LOOP_1042_2 {
		width_val {Type I LastRead 0 FirstWrite -1}
		outLayer2 {Type I LastRead 1 FirstWrite -1}
		outYuv {Type O LastRead -1 FirstWrite 1}}
	v_mix_444_to_422_false_s {
		outYuv {Type I LastRead 1 FirstWrite -1}
		height_val {Type I LastRead 0 FirstWrite -1}
		width_val {Type I LastRead 0 FirstWrite -1}
		out422 {Type O LastRead -1 FirstWrite 1}}
	v_mix_444_to_422_false_Pipeline_VITIS_LOOP_718_2 {
		width_val {Type I LastRead 0 FirstWrite -1}
		outYuv {Type I LastRead 1 FirstWrite -1}
		out422 {Type O LastRead -1 FirstWrite 1}}
	v_mix_422_to_420_false_s {
		out422 {Type I LastRead 1 FirstWrite -1}
		height_val {Type I LastRead 0 FirstWrite -1}
		width_val {Type I LastRead 0 FirstWrite -1}
		out420 {Type O LastRead -1 FirstWrite 1}}
	v_mix_422_to_420_false_Pipeline_VITIS_LOOP_508_2 {
		width_val {Type I LastRead 0 FirstWrite -1}
		out422 {Type I LastRead 1 FirstWrite -1}
		out420 {Type O LastRead -1 FirstWrite 1}}
	MultiPixStream2AXIvideo {
		out420 {Type I LastRead 1 FirstWrite -1}
		m_axis_video_V_data_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_keep_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_strb_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_user_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_last_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_id_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_dest_V {Type O LastRead -1 FirstWrite 1}
		Height {Type I LastRead 0 FirstWrite -1}
		WidthOut {Type I LastRead 0 FirstWrite -1}}
	MultiPixStream2AXIvideo_Pipeline_VITIS_LOOP_3519_3 {
		sof {Type I LastRead 0 FirstWrite -1}
		cols {Type I LastRead 0 FirstWrite -1}
		sub {Type I LastRead 0 FirstWrite -1}
		out420 {Type I LastRead 1 FirstWrite -1}
		m_axis_video_V_data_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_keep_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_strb_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_user_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_last_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_id_V {Type O LastRead -1 FirstWrite 1}
		m_axis_video_V_dest_V {Type O LastRead -1 FirstWrite 1}}
	reg_unsigned_short_1 {
		d {Type I LastRead 1 FirstWrite -1}}
	reg_unsigned_short_1 {
		d {Type I LastRead 1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "4629", "Max" : "1073938431"}
	, {"Name" : "Interval", "Min" : "4611", "Max" : "1073938427"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	HwReg_width_val { ap_none {  { HwReg_width_val in_data 0 12 }  { HwReg_width_val_ap_vld in_vld 0 1 } } }
	HwReg_height_val { ap_none {  { HwReg_height_val in_data 0 12 }  { HwReg_height_val_ap_vld in_vld 0 1 } } }
	HwReg_background_Y_R_val12 { ap_none {  { HwReg_background_Y_R_val12 in_data 0 8 }  { HwReg_background_Y_R_val12_ap_vld in_vld 0 1 } } }
	HwReg_background_U_G_val13 { ap_none {  { HwReg_background_U_G_val13 in_data 0 8 }  { HwReg_background_U_G_val13_ap_vld in_vld 0 1 } } }
	HwReg_background_V_B_val14 { ap_none {  { HwReg_background_V_B_val14 in_data 0 8 }  { HwReg_background_V_B_val14_ap_vld in_vld 0 1 } } }
	HwReg_layerEnable_val16 { ap_none {  { HwReg_layerEnable_val16 in_data 0 3 }  { HwReg_layerEnable_val16_ap_vld in_vld 0 1 } } }
	HwReg_layerEnableFlag_0_val { ap_none {  { HwReg_layerEnableFlag_0_val in_data 0 1 }  { HwReg_layerEnableFlag_0_val_ap_vld in_vld 0 1 } } }
	HwReg_layerEnableFlag_1_val { ap_none {  { HwReg_layerEnableFlag_1_val in_data 0 1 }  { HwReg_layerEnableFlag_1_val_ap_vld in_vld 0 1 } } }
	HwReg_layerEnableFlag_2_val { ap_none {  { HwReg_layerEnableFlag_2_val in_data 0 1 }  { HwReg_layerEnableFlag_2_val_ap_vld in_vld 0 1 } } }
	HwReg_layerAlpha_2_val17 { ap_none {  { HwReg_layerAlpha_2_val17 in_data 0 9 }  { HwReg_layerAlpha_2_val17_ap_vld in_vld 0 1 } } }
	HwReg_layerStartX_1_val18 { ap_none {  { HwReg_layerStartX_1_val18 in_data 0 16 }  { HwReg_layerStartX_1_val18_ap_vld in_vld 0 1 } } }
	HwReg_layerStartX_2_val19 { ap_none {  { HwReg_layerStartX_2_val19 in_data 0 16 }  { HwReg_layerStartX_2_val19_ap_vld in_vld 0 1 } } }
	HwReg_layerStartY_1_val20 { ap_none {  { HwReg_layerStartY_1_val20 in_data 0 16 }  { HwReg_layerStartY_1_val20_ap_vld in_vld 0 1 } } }
	HwReg_layerStartY_2_val21 { ap_none {  { HwReg_layerStartY_2_val21 in_data 0 16 }  { HwReg_layerStartY_2_val21_ap_vld in_vld 0 1 } } }
	HwReg_layerWidth_1_val { ap_none {  { HwReg_layerWidth_1_val in_data 0 16 }  { HwReg_layerWidth_1_val_ap_vld in_vld 0 1 } } }
	HwReg_layerWidth_2_val { ap_none {  { HwReg_layerWidth_2_val in_data 0 16 }  { HwReg_layerWidth_2_val_ap_vld in_vld 0 1 } } }
	HwReg_layerHeight_1_val { ap_none {  { HwReg_layerHeight_1_val in_data 0 16 }  { HwReg_layerHeight_1_val_ap_vld in_vld 0 1 } } }
	HwReg_layerHeight_2_val { ap_none {  { HwReg_layerHeight_2_val in_data 0 16 }  { HwReg_layerHeight_2_val_ap_vld in_vld 0 1 } } }
	HwReg_layerScaleFactor_1_val26 { ap_none {  { HwReg_layerScaleFactor_1_val26 in_data 0 8 }  { HwReg_layerScaleFactor_1_val26_ap_vld in_vld 0 1 } } }
	HwReg_layerScaleFactor_2_val27 { ap_none {  { HwReg_layerScaleFactor_2_val27 in_data 0 8 }  { HwReg_layerScaleFactor_2_val27_ap_vld in_vld 0 1 } } }
	s_axis_video_V_data_V { axis {  { s_axis_video_TDATA in_data 0 24 } } }
	s_axis_video_V_keep_V { axis {  { s_axis_video_TKEEP in_data 0 3 } } }
	s_axis_video_V_strb_V { axis {  { s_axis_video_TSTRB in_data 0 3 } } }
	s_axis_video_V_user_V { axis {  { s_axis_video_TUSER in_data 0 1 } } }
	s_axis_video_V_last_V { axis {  { s_axis_video_TLAST in_data 0 1 } } }
	s_axis_video_V_id_V { axis {  { s_axis_video_TID in_data 0 1 } } }
	s_axis_video_V_dest_V { axis {  { s_axis_video_TDEST in_data 0 1 }  { s_axis_video_TVALID in_vld 0 1 }  { s_axis_video_TREADY in_acc 1 1 } } }
	s_axis_video1_V_data_V { axis {  { s_axis_video1_TDATA in_data 0 24 } } }
	s_axis_video1_V_keep_V { axis {  { s_axis_video1_TKEEP in_data 0 3 } } }
	s_axis_video1_V_strb_V { axis {  { s_axis_video1_TSTRB in_data 0 3 } } }
	s_axis_video1_V_user_V { axis {  { s_axis_video1_TUSER in_data 0 1 } } }
	s_axis_video1_V_last_V { axis {  { s_axis_video1_TLAST in_data 0 1 } } }
	s_axis_video1_V_id_V { axis {  { s_axis_video1_TID in_data 0 1 } } }
	s_axis_video1_V_dest_V { axis {  { s_axis_video1_TDEST in_data 0 1 }  { s_axis_video1_TVALID in_vld 0 1 }  { s_axis_video1_TREADY in_acc 1 1 } } }
	s_axis_video2_V_data_V { axis {  { s_axis_video2_TDATA in_data 0 24 } } }
	s_axis_video2_V_keep_V { axis {  { s_axis_video2_TKEEP in_data 0 3 } } }
	s_axis_video2_V_strb_V { axis {  { s_axis_video2_TSTRB in_data 0 3 } } }
	s_axis_video2_V_user_V { axis {  { s_axis_video2_TUSER in_data 0 1 } } }
	s_axis_video2_V_last_V { axis {  { s_axis_video2_TLAST in_data 0 1 } } }
	s_axis_video2_V_id_V { axis {  { s_axis_video2_TID in_data 0 1 } } }
	s_axis_video2_V_dest_V { axis {  { s_axis_video2_TDEST in_data 0 1 }  { s_axis_video2_TVALID in_vld 0 1 }  { s_axis_video2_TREADY in_acc 1 1 } } }
	m_axis_video_V_data_V { axis {  { m_axis_video_TDATA out_data 1 24 } } }
	m_axis_video_V_keep_V { axis {  { m_axis_video_TKEEP out_data 1 3 } } }
	m_axis_video_V_strb_V { axis {  { m_axis_video_TSTRB out_data 1 3 } } }
	m_axis_video_V_user_V { axis {  { m_axis_video_TUSER out_data 1 1 } } }
	m_axis_video_V_last_V { axis {  { m_axis_video_TLAST out_data 1 1 } } }
	m_axis_video_V_id_V { axis {  { m_axis_video_TID out_data 1 1 } } }
	m_axis_video_V_dest_V { axis {  { m_axis_video_TDEST out_data 1 1 }  { m_axis_video_TVALID out_vld 1 1 }  { m_axis_video_TREADY out_acc 0 1 } } }
}
