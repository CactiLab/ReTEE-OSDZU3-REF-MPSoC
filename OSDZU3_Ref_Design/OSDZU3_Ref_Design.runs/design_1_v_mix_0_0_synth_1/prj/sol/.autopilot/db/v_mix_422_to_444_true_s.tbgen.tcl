set moduleName v_mix_422_to_444_true_s
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
set C_modelName {v_mix_422_to_444<true>}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ srcLayer1Yuv422 int 24 regular {fifo 0 volatile }  }
	{ height uint 16 regular {ap_stable 0} }
	{ width uint 16 regular {ap_stable 0} }
	{ layerEnableFlag uint 1 regular {ap_stable 0} }
	{ srcLayer1Yuv int 24 regular {fifo 1 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "srcLayer1Yuv422", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "height", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "width", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "layerEnableFlag", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "srcLayer1Yuv", "interface" : "fifo", "bitwidth" : 24, "direction" : "WRITEONLY"} ]}
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
	{ srcLayer1Yuv422_dout sc_in sc_lv 24 signal 0 } 
	{ srcLayer1Yuv422_empty_n sc_in sc_logic 1 signal 0 } 
	{ srcLayer1Yuv422_read sc_out sc_logic 1 signal 0 } 
	{ srcLayer1Yuv422_num_data_valid sc_in sc_lv 3 signal 0 } 
	{ srcLayer1Yuv422_fifo_cap sc_in sc_lv 3 signal 0 } 
	{ height sc_in sc_lv 16 signal 1 } 
	{ width sc_in sc_lv 16 signal 2 } 
	{ layerEnableFlag sc_in sc_lv 1 signal 3 } 
	{ srcLayer1Yuv_din sc_out sc_lv 24 signal 4 } 
	{ srcLayer1Yuv_full_n sc_in sc_logic 1 signal 4 } 
	{ srcLayer1Yuv_write sc_out sc_logic 1 signal 4 } 
	{ srcLayer1Yuv_num_data_valid sc_in sc_lv 32 signal 4 } 
	{ srcLayer1Yuv_fifo_cap sc_in sc_lv 32 signal 4 } 
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
 	{ "name": "srcLayer1Yuv422_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "dout" }} , 
 	{ "name": "srcLayer1Yuv422_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "empty_n" }} , 
 	{ "name": "srcLayer1Yuv422_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "read" }} , 
 	{ "name": "srcLayer1Yuv422_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "num_data_valid" }} , 
 	{ "name": "srcLayer1Yuv422_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "fifo_cap" }} , 
 	{ "name": "height", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "height", "role": "default" }} , 
 	{ "name": "width", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "width", "role": "default" }} , 
 	{ "name": "layerEnableFlag", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "layerEnableFlag", "role": "default" }} , 
 	{ "name": "srcLayer1Yuv_din", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "din" }} , 
 	{ "name": "srcLayer1Yuv_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "full_n" }} , 
 	{ "name": "srcLayer1Yuv_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "write" }} , 
 	{ "name": "srcLayer1Yuv_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "num_data_valid" }} , 
 	{ "name": "srcLayer1Yuv_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "fifo_cap" }}  ]}

set ArgLastReadFirstWriteLatency {
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
		p_0_0_0200352_out {Type IO LastRead 2 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "1", "Max" : "1073938426"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1073938426"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	srcLayer1Yuv422 { ap_fifo {  { srcLayer1Yuv422_dout fifo_data_in 0 24 }  { srcLayer1Yuv422_empty_n fifo_status 0 1 }  { srcLayer1Yuv422_read fifo_port_we 1 1 }  { srcLayer1Yuv422_num_data_valid fifo_status_num_data_valid 0 3 }  { srcLayer1Yuv422_fifo_cap fifo_update 0 3 } } }
	height { ap_stable {  { height in_data 0 16 } } }
	width { ap_stable {  { width in_data 0 16 } } }
	layerEnableFlag { ap_stable {  { layerEnableFlag in_data 0 1 } } }
	srcLayer1Yuv { ap_fifo {  { srcLayer1Yuv_din fifo_data_in 1 24 }  { srcLayer1Yuv_full_n fifo_status 0 1 }  { srcLayer1Yuv_write fifo_port_we 1 1 }  { srcLayer1Yuv_num_data_valid fifo_status_num_data_valid 0 32 }  { srcLayer1Yuv_fifo_cap fifo_update 0 32 } } }
}
