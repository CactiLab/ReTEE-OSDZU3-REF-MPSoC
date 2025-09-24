set moduleName v_mix_core_alpha_true_false_s
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
set C_modelName {v_mix_core_alpha<true, false>}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ outLayer1 int 24 regular {fifo 0 volatile }  }
	{ srcLayer2x int 24 regular {fifo 0 volatile }  }
	{ hwReg_width_val int 12 regular {ap_stable 0} }
	{ hwReg_height_val int 12 regular {ap_stable 0} }
	{ hwReg_layerEnable_val int 3 regular {ap_stable 0} }
	{ hwReg_layerAlpha_2_val int 9 regular {ap_stable 0} }
	{ hwReg_layerStartX_2_val int 16 regular {ap_stable 0} }
	{ hwReg_layerStartY_2_val int 16 regular {ap_stable 0} }
	{ hwReg_layerWidth_2_val int 16 regular {ap_stable 0} }
	{ hwReg_layerHeight_2_val int 16 regular {ap_stable 0} }
	{ hwReg_layerScaleFactor_2_val int 8 regular {ap_stable 0} }
	{ outLayer2 int 24 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "outLayer1", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "srcLayer2x", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_width_val", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_height_val", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_layerEnable_val", "interface" : "wire", "bitwidth" : 3, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_layerAlpha_2_val", "interface" : "wire", "bitwidth" : 9, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_layerStartX_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_layerStartY_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_layerWidth_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_layerHeight_2_val", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "hwReg_layerScaleFactor_2_val", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "outLayer2", "interface" : "fifo", "bitwidth" : 24, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 34
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
	{ outLayer1_dout sc_in sc_lv 24 signal 0 } 
	{ outLayer1_empty_n sc_in sc_logic 1 signal 0 } 
	{ outLayer1_read sc_out sc_logic 1 signal 0 } 
	{ outLayer1_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ outLayer1_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ srcLayer2x_dout sc_in sc_lv 24 signal 1 } 
	{ srcLayer2x_empty_n sc_in sc_logic 1 signal 1 } 
	{ srcLayer2x_read sc_out sc_logic 1 signal 1 } 
	{ srcLayer2x_num_data_valid sc_in sc_lv 3 signal 1 } 
	{ srcLayer2x_fifo_cap sc_in sc_lv 3 signal 1 } 
	{ hwReg_width_val sc_in sc_lv 12 signal 2 } 
	{ hwReg_height_val sc_in sc_lv 12 signal 3 } 
	{ hwReg_layerEnable_val sc_in sc_lv 3 signal 4 } 
	{ hwReg_layerAlpha_2_val sc_in sc_lv 9 signal 5 } 
	{ hwReg_layerStartX_2_val sc_in sc_lv 16 signal 6 } 
	{ hwReg_layerStartY_2_val sc_in sc_lv 16 signal 7 } 
	{ hwReg_layerWidth_2_val sc_in sc_lv 16 signal 8 } 
	{ hwReg_layerHeight_2_val sc_in sc_lv 16 signal 9 } 
	{ hwReg_layerScaleFactor_2_val sc_in sc_lv 8 signal 10 } 
	{ outLayer2_din sc_out sc_lv 24 signal 11 } 
	{ outLayer2_full_n sc_in sc_logic 1 signal 11 } 
	{ outLayer2_write sc_out sc_logic 1 signal 11 } 
	{ outLayer2_num_data_valid sc_in sc_lv 32 signal 11 } 
	{ outLayer2_fifo_cap sc_in sc_lv 32 signal 11 } 
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
 	{ "name": "outLayer1_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "outLayer1", "role": "dout" }} , 
 	{ "name": "outLayer1_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outLayer1", "role": "empty_n" }} , 
 	{ "name": "outLayer1_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outLayer1", "role": "read" }} , 
 	{ "name": "outLayer1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "outLayer1", "role": "num_data_valid" }} , 
 	{ "name": "outLayer1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "outLayer1", "role": "fifo_cap" }} , 
 	{ "name": "srcLayer2x_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "srcLayer2x", "role": "dout" }} , 
 	{ "name": "srcLayer2x_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer2x", "role": "empty_n" }} , 
 	{ "name": "srcLayer2x_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer2x", "role": "read" }} , 
 	{ "name": "srcLayer2x_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer2x", "role": "num_data_valid" }} , 
 	{ "name": "srcLayer2x_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer2x", "role": "fifo_cap" }} , 
 	{ "name": "hwReg_width_val", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "hwReg_width_val", "role": "default" }} , 
 	{ "name": "hwReg_height_val", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "hwReg_height_val", "role": "default" }} , 
 	{ "name": "hwReg_layerEnable_val", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "hwReg_layerEnable_val", "role": "default" }} , 
 	{ "name": "hwReg_layerAlpha_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":9, "type": "signal", "bundle":{"name": "hwReg_layerAlpha_2_val", "role": "default" }} , 
 	{ "name": "hwReg_layerStartX_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "hwReg_layerStartX_2_val", "role": "default" }} , 
 	{ "name": "hwReg_layerStartY_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "hwReg_layerStartY_2_val", "role": "default" }} , 
 	{ "name": "hwReg_layerWidth_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "hwReg_layerWidth_2_val", "role": "default" }} , 
 	{ "name": "hwReg_layerHeight_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "hwReg_layerHeight_2_val", "role": "default" }} , 
 	{ "name": "hwReg_layerScaleFactor_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "hwReg_layerScaleFactor_2_val", "role": "default" }} , 
 	{ "name": "outLayer2_din", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "outLayer2", "role": "din" }} , 
 	{ "name": "outLayer2_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outLayer2", "role": "full_n" }} , 
 	{ "name": "outLayer2_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "outLayer2", "role": "write" }} , 
 	{ "name": "outLayer2_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "outLayer2", "role": "num_data_valid" }} , 
 	{ "name": "outLayer2_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "outLayer2", "role": "fifo_cap" }}  ]}

set ArgLastReadFirstWriteLatency {
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
		d {Type I LastRead 1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "4610", "Max" : "8311682"}
	, {"Name" : "Interval", "Min" : "4610", "Max" : "8311682"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	outLayer1 { ap_fifo {  { outLayer1_dout fifo_data_in 0 24 }  { outLayer1_empty_n fifo_status 0 1 }  { outLayer1_read fifo_port_we 1 1 }  { outLayer1_num_data_valid fifo_status_num_data_valid 0 3 }  { outLayer1_fifo_cap fifo_update 0 3 } } }
	srcLayer2x { ap_fifo {  { srcLayer2x_dout fifo_data_in 0 24 }  { srcLayer2x_empty_n fifo_status 0 1 }  { srcLayer2x_read fifo_port_we 1 1 }  { srcLayer2x_num_data_valid fifo_status_num_data_valid 0 3 }  { srcLayer2x_fifo_cap fifo_update 0 3 } } }
	hwReg_width_val { ap_stable {  { hwReg_width_val in_data 0 12 } } }
	hwReg_height_val { ap_stable {  { hwReg_height_val in_data 0 12 } } }
	hwReg_layerEnable_val { ap_stable {  { hwReg_layerEnable_val in_data 0 3 } } }
	hwReg_layerAlpha_2_val { ap_stable {  { hwReg_layerAlpha_2_val in_data 0 9 } } }
	hwReg_layerStartX_2_val { ap_stable {  { hwReg_layerStartX_2_val in_data 0 16 } } }
	hwReg_layerStartY_2_val { ap_stable {  { hwReg_layerStartY_2_val in_data 0 16 } } }
	hwReg_layerWidth_2_val { ap_stable {  { hwReg_layerWidth_2_val in_data 0 16 } } }
	hwReg_layerHeight_2_val { ap_stable {  { hwReg_layerHeight_2_val in_data 0 16 } } }
	hwReg_layerScaleFactor_2_val { ap_stable {  { hwReg_layerScaleFactor_2_val in_data 0 8 } } }
	outLayer2 { ap_fifo {  { outLayer2_din fifo_data_in 1 24 }  { outLayer2_full_n fifo_status 0 1 }  { outLayer2_write fifo_port_we 1 1 }  { outLayer2_num_data_valid fifo_status_num_data_valid 0 32 }  { outLayer2_fifo_cap fifo_update 0 32 } } }
}
