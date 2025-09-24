set moduleName v_mix_core_alpha_false_false_s
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
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
set C_modelName {v_mix_core_alpha<false, false>}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ outLayer0 int 24 regular {fifo 0 volatile }  }
	{ srcLayer1x int 24 regular {fifo 0 volatile }  }
	{ HwReg_width_val int 12 regular {ap_stable 0} }
	{ HwReg_height_val int 12 regular {ap_stable 0} }
	{ HwReg_background_Y_R_val12 int 8 regular {ap_stable 0} }
	{ HwReg_background_U_G_val13 int 8 regular {ap_stable 0} }
	{ HwReg_background_V_B_val14 int 8 regular {ap_stable 0} }
	{ HwReg_layerEnable_val16 int 2 regular {ap_stable 0} }
	{ HwReg_layerStartX_1_val18 int 16 regular {ap_stable 0} }
	{ HwReg_layerStartY_1_val20 int 16 regular {ap_stable 0} }
	{ HwReg_layerWidth_1_val int 16 regular {ap_stable 0} }
	{ HwReg_layerHeight_1_val int 16 regular {ap_stable 0} }
	{ HwReg_layerScaleFactor_1_val26 int 8 regular {ap_stable 0} }
	{ outLayer1 int 24 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "outLayer0", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "srcLayer1x", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_width_val", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_height_val", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_background_Y_R_val12", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_background_U_G_val13", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_background_V_B_val14", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerEnable_val16", "interface" : "wire", "bitwidth" : 2, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerStartX_1_val18", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerStartY_1_val20", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerWidth_1_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerHeight_1_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerScaleFactor_1_val26", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "outLayer1", "interface" : "fifo", "bitwidth" : 24, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 36
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ start_full_n sc_in sc_logic 1 signal -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_continue sc_in sc_logic 1 continue -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ start_out sc_out sc_logic 1 signal -1 } 
	{ start_write sc_out sc_logic 1 signal -1 } 
	{ outLayer0_dout sc_in sc_lv 24 signal 0 } 
	{ outLayer0_empty_n sc_in sc_logic 1 signal 0 } 
	{ outLayer0_read sc_out sc_logic 1 signal 0 } 
	{ outLayer0_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ outLayer0_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ srcLayer1x_dout sc_in sc_lv 24 signal 1 } 
	{ srcLayer1x_empty_n sc_in sc_logic 1 signal 1 } 
	{ srcLayer1x_read sc_out sc_logic 1 signal 1 } 
	{ srcLayer1x_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ srcLayer1x_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ HwReg_width_val sc_in sc_lv 12 signal 2 } 
	{ HwReg_height_val sc_in sc_lv 12 signal 3 } 
	{ HwReg_background_Y_R_val12 sc_in sc_lv 8 signal 4 } 
	{ HwReg_background_U_G_val13 sc_in sc_lv 8 signal 5 } 
	{ HwReg_background_V_B_val14 sc_in sc_lv 8 signal 6 } 
	{ HwReg_layerEnable_val16 sc_in sc_lv 2 signal 7 } 
	{ HwReg_layerStartX_1_val18 sc_in sc_lv 16 signal 8 } 
	{ HwReg_layerStartY_1_val20 sc_in sc_lv 16 signal 9 } 
	{ HwReg_layerWidth_1_val sc_in sc_lv 16 signal 10 } 
	{ HwReg_layerHeight_1_val sc_in sc_lv 16 signal 11 } 
	{ HwReg_layerScaleFactor_1_val26 sc_in sc_lv 8 signal 12 } 
	{ outLayer1_din sc_out sc_lv 24 signal 13 } 
	{ outLayer1_full_n sc_in sc_logic 1 signal 13 } 
	{ outLayer1_write sc_out sc_logic 1 signal 13 } 
	{ outLayer1_num_data_valid sc_in sc_lv 32 signal 13 } 
	{ outLayer1_fifo_cap sc_in sc_lv 32 signal 13 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "start_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_full_n", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_continue", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "continue", "bundle":{"name": "ap_continue", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "start_out", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_out", "role": "default" }} , 
 	{ "name": "start_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "start_write", "role": "default" }} , 
 	{ "name": "outLayer0_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "outLayer0", "role": "dout" }} , 
 	{ "name": "outLayer0_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outLayer0", "role": "empty_n" }} , 
 	{ "name": "outLayer0_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outLayer0", "role": "read" }} , 
 	{ "name": "outLayer0_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "outLayer0", "role": "num_data_valid" }} , 
 	{ "name": "outLayer0_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "outLayer0", "role": "fifo_cap" }} , 
 	{ "name": "srcLayer1x_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "srcLayer1x", "role": "dout" }} , 
 	{ "name": "srcLayer1x_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1x", "role": "empty_n" }} , 
 	{ "name": "srcLayer1x_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1x", "role": "read" }} , 
 	{ "name": "srcLayer1x_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer1x", "role": "num_data_valid" }} , 
 	{ "name": "srcLayer1x_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer1x", "role": "fifo_cap" }} , 
 	{ "name": "HwReg_width_val", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "HwReg_width_val", "role": "default" }} , 
 	{ "name": "HwReg_height_val", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "HwReg_height_val", "role": "default" }} , 
 	{ "name": "HwReg_background_Y_R_val12", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_background_Y_R_val12", "role": "default" }} , 
 	{ "name": "HwReg_background_U_G_val13", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_background_U_G_val13", "role": "default" }} , 
 	{ "name": "HwReg_background_V_B_val14", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_background_V_B_val14", "role": "default" }} , 
 	{ "name": "HwReg_layerEnable_val16", "direction": "in", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "HwReg_layerEnable_val16", "role": "default" }} , 
 	{ "name": "HwReg_layerStartX_1_val18", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerStartX_1_val18", "role": "default" }} , 
 	{ "name": "HwReg_layerStartY_1_val20", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerStartY_1_val20", "role": "default" }} , 
 	{ "name": "HwReg_layerWidth_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerWidth_1_val", "role": "default" }} , 
 	{ "name": "HwReg_layerHeight_1_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "HwReg_layerHeight_1_val", "role": "default" }} , 
 	{ "name": "HwReg_layerScaleFactor_1_val26", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "HwReg_layerScaleFactor_1_val26", "role": "default" }} , 
 	{ "name": "outLayer1_din", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "outLayer1", "role": "din" }} , 
 	{ "name": "outLayer1_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outLayer1", "role": "full_n" }} , 
 	{ "name": "outLayer1_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outLayer1", "role": "write" }} , 
 	{ "name": "outLayer1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "outLayer1", "role": "num_data_valid" }} , 
 	{ "name": "outLayer1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "outLayer1", "role": "fifo_cap" }}  ]}

set ArgLastReadFirstWriteLatency {
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
		outLayer0 {Type I LastRead 1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "4417", "Max" : "8305201"}
	, {"Name" : "Interval", "Min" : "4417", "Max" : "8305201"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	outLayer0 { ap_fifo {  { outLayer0_dout fifo_data_in 0 24 }  { outLayer0_empty_n fifo_status 0 1 }  { outLayer0_read fifo_port_we 1 1 }  { outLayer0_num_data_valid fifo_status_num_data_valid 0 3 }  { outLayer0_fifo_cap fifo_update 0 3 } } }
	srcLayer1x { ap_fifo {  { srcLayer1x_dout fifo_data_in 0 24 }  { srcLayer1x_empty_n fifo_status 0 1 }  { srcLayer1x_read fifo_port_we 1 1 }  { srcLayer1x_num_data_valid fifo_status_num_data_valid 0 3 }  { srcLayer1x_fifo_cap fifo_update 0 3 } } }
	HwReg_width_val { ap_stable {  { HwReg_width_val in_data 0 12 } } }
	HwReg_height_val { ap_stable {  { HwReg_height_val in_data 0 12 } } }
	HwReg_background_Y_R_val12 { ap_stable {  { HwReg_background_Y_R_val12 in_data 0 8 } } }
	HwReg_background_U_G_val13 { ap_stable {  { HwReg_background_U_G_val13 in_data 0 8 } } }
	HwReg_background_V_B_val14 { ap_stable {  { HwReg_background_V_B_val14 in_data 0 8 } } }
	HwReg_layerEnable_val16 { ap_stable {  { HwReg_layerEnable_val16 in_data 0 2 } } }
	HwReg_layerStartX_1_val18 { ap_stable {  { HwReg_layerStartX_1_val18 in_data 0 16 } } }
	HwReg_layerStartY_1_val20 { ap_stable {  { HwReg_layerStartY_1_val20 in_data 0 16 } } }
	HwReg_layerWidth_1_val { ap_stable {  { HwReg_layerWidth_1_val in_data 0 16 } } }
	HwReg_layerHeight_1_val { ap_stable {  { HwReg_layerHeight_1_val in_data 0 16 } } }
	HwReg_layerScaleFactor_1_val26 { ap_stable {  { HwReg_layerScaleFactor_1_val26 in_data 0 8 } } }
	outLayer1 { ap_fifo {  { outLayer1_din fifo_data_in 1 24 }  { outLayer1_full_n fifo_status 0 1 }  { outLayer1_write fifo_port_we 1 1 }  { outLayer1_num_data_valid fifo_status_num_data_valid 0 32 }  { outLayer1_fifo_cap fifo_update 0 32 } } }
}
