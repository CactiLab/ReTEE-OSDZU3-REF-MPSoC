set moduleName v_mix_yuv2rgb_false_s
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
set C_modelName {v_mix_yuv2rgb<false>}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ srcLayer2Yuv int 24 regular {fifo 0 volatile }  }
	{ HwReg_layerHeight_2_val int 12 regular {ap_stable 0} }
	{ HwReg_layerWidth_2_val int 12 regular {ap_stable 0} }
	{ HwReg_layerEnableFlag_2_val int 1 regular {ap_stable 0} }
	{ srcLayer2Rgb int 24 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "srcLayer2Yuv", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerHeight_2_val", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerWidth_2_val", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "HwReg_layerEnableFlag_2_val", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "srcLayer2Rgb", "interface" : "fifo", "bitwidth" : 24, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 23
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
	{ srcLayer2Yuv_dout sc_in sc_lv 24 signal 0 } 
	{ srcLayer2Yuv_empty_n sc_in sc_logic 1 signal 0 } 
	{ srcLayer2Yuv_read sc_out sc_logic 1 signal 0 } 
	{ srcLayer2Yuv_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ srcLayer2Yuv_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ HwReg_layerHeight_2_val sc_in sc_lv 12 signal 1 } 
	{ HwReg_layerWidth_2_val sc_in sc_lv 12 signal 2 } 
	{ HwReg_layerEnableFlag_2_val sc_in sc_lv 1 signal 3 } 
	{ srcLayer2Rgb_din sc_out sc_lv 24 signal 4 } 
	{ srcLayer2Rgb_full_n sc_in sc_logic 1 signal 4 } 
	{ srcLayer2Rgb_write sc_out sc_logic 1 signal 4 } 
	{ srcLayer2Rgb_num_data_valid sc_in sc_lv 32 signal 4 } 
	{ srcLayer2Rgb_fifo_cap sc_in sc_lv 32 signal 4 } 
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
 	{ "name": "srcLayer2Yuv_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "srcLayer2Yuv", "role": "dout" }} , 
 	{ "name": "srcLayer2Yuv_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer2Yuv", "role": "empty_n" }} , 
 	{ "name": "srcLayer2Yuv_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer2Yuv", "role": "read" }} , 
 	{ "name": "srcLayer2Yuv_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer2Yuv", "role": "num_data_valid" }} , 
 	{ "name": "srcLayer2Yuv_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer2Yuv", "role": "fifo_cap" }} , 
 	{ "name": "HwReg_layerHeight_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "HwReg_layerHeight_2_val", "role": "default" }} , 
 	{ "name": "HwReg_layerWidth_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "HwReg_layerWidth_2_val", "role": "default" }} , 
 	{ "name": "HwReg_layerEnableFlag_2_val", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "HwReg_layerEnableFlag_2_val", "role": "default" }} , 
 	{ "name": "srcLayer2Rgb_din", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "srcLayer2Rgb", "role": "din" }} , 
 	{ "name": "srcLayer2Rgb_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer2Rgb", "role": "full_n" }} , 
 	{ "name": "srcLayer2Rgb_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer2Rgb", "role": "write" }} , 
 	{ "name": "srcLayer2Rgb_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "srcLayer2Rgb", "role": "num_data_valid" }} , 
 	{ "name": "srcLayer2Rgb_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "srcLayer2Rgb", "role": "fifo_cap" }}  ]}

set ArgLastReadFirstWriteLatency {
	v_mix_yuv2rgb_false_s {
		srcLayer2Yuv {Type I LastRead 1 FirstWrite -1}
		HwReg_layerHeight_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerWidth_2_val {Type I LastRead 0 FirstWrite -1}
		HwReg_layerEnableFlag_2_val {Type I LastRead 0 FirstWrite -1}
		srcLayer2Rgb {Type O LastRead -1 FirstWrite 1}}
	v_mix_yuv2rgb_false_Pipeline_VITIS_LOOP_897_2 {
		empty {Type I LastRead 0 FirstWrite -1}
		srcLayer2Yuv {Type I LastRead 1 FirstWrite -1}
		srcLayer2Rgb {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "8303041"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "8303041"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	srcLayer2Yuv { ap_fifo {  { srcLayer2Yuv_dout fifo_data_in 0 24 }  { srcLayer2Yuv_empty_n fifo_status 0 1 }  { srcLayer2Yuv_read fifo_port_we 1 1 }  { srcLayer2Yuv_num_data_valid fifo_status_num_data_valid 0 3 }  { srcLayer2Yuv_fifo_cap fifo_update 0 3 } } }
	HwReg_layerHeight_2_val { ap_stable {  { HwReg_layerHeight_2_val in_data 0 12 } } }
	HwReg_layerWidth_2_val { ap_stable {  { HwReg_layerWidth_2_val in_data 0 12 } } }
	HwReg_layerEnableFlag_2_val { ap_stable {  { HwReg_layerEnableFlag_2_val in_data 0 1 } } }
	srcLayer2Rgb { ap_fifo {  { srcLayer2Rgb_din fifo_data_in 1 24 }  { srcLayer2Rgb_full_n fifo_status 0 1 }  { srcLayer2Rgb_write fifo_port_we 1 1 }  { srcLayer2Rgb_num_data_valid fifo_status_num_data_valid 0 32 }  { srcLayer2Rgb_fifo_cap fifo_update 0 32 } } }
}
