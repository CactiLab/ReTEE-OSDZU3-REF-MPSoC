set moduleName Bytes2MultiPixStream_Pipeline_VITIS_LOOP_954_1
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type loop_auto_rewind
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 15
set C_modelName {Bytes2MultiPixStream_Pipeline_VITIS_LOOP_954_1}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ trunc_ln941_1 int 12 regular {ap_stable 0} }
	{ icmp_ln944 int 1 regular {ap_stable 0} }
	{ cmp83_6 int 1 regular {ap_stable 0} }
	{ cmp83_5 int 1 regular {ap_stable 0} }
	{ cmp83_4 int 1 regular {ap_stable 0} }
	{ icmp6 int 1 regular {ap_stable 0} }
	{ cmp83_2 int 1 regular {ap_stable 0} }
	{ sub79 int 13 regular {ap_stable 0} }
	{ img int 24 regular {fifo 1 volatile }  }
	{ icmp3 int 1 regular {ap_stable 0} }
	{ bytePlanes_plane0 int 64 regular {fifo 0 volatile }  }
	{ VideoFormat_val int 5 regular {ap_stable 0} }
	{ empty int 1 regular  }
	{ bytePlanes_plane1 int 64 regular {fifo 0 volatile }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "trunc_ln941_1", "interface" : "wire", "bitwidth" : 12, "direction" : "READONLY"} , 
 	{ "Name" : "icmp_ln944", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "cmp83_6", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "cmp83_5", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "cmp83_4", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "icmp6", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "cmp83_2", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "sub79", "interface" : "wire", "bitwidth" : 13, "direction" : "READONLY"} , 
 	{ "Name" : "img", "interface" : "fifo", "bitwidth" : 24, "direction" : "WRITEONLY"} , 
 	{ "Name" : "icmp3", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "bytePlanes_plane0", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} , 
 	{ "Name" : "VideoFormat_val", "interface" : "wire", "bitwidth" : 5, "direction" : "READONLY"} , 
 	{ "Name" : "empty", "interface" : "wire", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "bytePlanes_plane1", "interface" : "fifo", "bitwidth" : 64, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 32
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ img_din sc_out sc_lv 24 signal 8 } 
	{ img_full_n sc_in sc_logic 1 signal 8 } 
	{ img_write sc_out sc_logic 1 signal 8 } 
	{ img_num_data_valid sc_in sc_lv 32 signal 8 } 
	{ img_fifo_cap sc_in sc_lv 32 signal 8 } 
	{ bytePlanes_plane0_dout sc_in sc_lv 64 signal 10 } 
	{ bytePlanes_plane0_empty_n sc_in sc_logic 1 signal 10 } 
	{ bytePlanes_plane0_read sc_out sc_logic 1 signal 10 } 
	{ bytePlanes_plane0_num_data_valid sc_in sc_lv 11 signal 10 } 
	{ bytePlanes_plane0_fifo_cap sc_in sc_lv 11 signal 10 } 
	{ bytePlanes_plane1_dout sc_in sc_lv 64 signal 13 } 
	{ bytePlanes_plane1_empty_n sc_in sc_logic 1 signal 13 } 
	{ bytePlanes_plane1_read sc_out sc_logic 1 signal 13 } 
	{ bytePlanes_plane1_num_data_valid sc_in sc_lv 11 signal 13 } 
	{ bytePlanes_plane1_fifo_cap sc_in sc_lv 11 signal 13 } 
	{ trunc_ln941_1 sc_in sc_lv 12 signal 0 } 
	{ icmp_ln944 sc_in sc_lv 1 signal 1 } 
	{ cmp83_6 sc_in sc_lv 1 signal 2 } 
	{ cmp83_5 sc_in sc_lv 1 signal 3 } 
	{ cmp83_4 sc_in sc_lv 1 signal 4 } 
	{ icmp6 sc_in sc_lv 1 signal 5 } 
	{ cmp83_2 sc_in sc_lv 1 signal 6 } 
	{ sub79 sc_in sc_lv 13 signal 7 } 
	{ icmp3 sc_in sc_lv 1 signal 9 } 
	{ VideoFormat_val sc_in sc_lv 5 signal 11 } 
	{ empty sc_in sc_lv 1 signal 12 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "img_din", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "img", "role": "din" }} , 
 	{ "name": "img_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "img", "role": "full_n" }} , 
 	{ "name": "img_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "img", "role": "write" }} , 
 	{ "name": "img_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "img", "role": "num_data_valid" }} , 
 	{ "name": "img_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "img", "role": "fifo_cap" }} , 
 	{ "name": "bytePlanes_plane0_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "bytePlanes_plane0", "role": "dout" }} , 
 	{ "name": "bytePlanes_plane0_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bytePlanes_plane0", "role": "empty_n" }} , 
 	{ "name": "bytePlanes_plane0_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bytePlanes_plane0", "role": "read" }} , 
 	{ "name": "bytePlanes_plane0_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "bytePlanes_plane0", "role": "num_data_valid" }} , 
 	{ "name": "bytePlanes_plane0_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "bytePlanes_plane0", "role": "fifo_cap" }} , 
 	{ "name": "bytePlanes_plane1_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "bytePlanes_plane1", "role": "dout" }} , 
 	{ "name": "bytePlanes_plane1_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bytePlanes_plane1", "role": "empty_n" }} , 
 	{ "name": "bytePlanes_plane1_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "bytePlanes_plane1", "role": "read" }} , 
 	{ "name": "bytePlanes_plane1_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "bytePlanes_plane1", "role": "num_data_valid" }} , 
 	{ "name": "bytePlanes_plane1_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":11, "type": "signal", "bundle":{"name": "bytePlanes_plane1", "role": "fifo_cap" }} , 
 	{ "name": "trunc_ln941_1", "direction": "in", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "trunc_ln941_1", "role": "default" }} , 
 	{ "name": "icmp_ln944", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "icmp_ln944", "role": "default" }} , 
 	{ "name": "cmp83_6", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cmp83_6", "role": "default" }} , 
 	{ "name": "cmp83_5", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cmp83_5", "role": "default" }} , 
 	{ "name": "cmp83_4", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cmp83_4", "role": "default" }} , 
 	{ "name": "icmp6", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "icmp6", "role": "default" }} , 
 	{ "name": "cmp83_2", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "cmp83_2", "role": "default" }} , 
 	{ "name": "sub79", "direction": "in", "datatype": "sc_lv", "bitwidth":13, "type": "signal", "bundle":{"name": "sub79", "role": "default" }} , 
 	{ "name": "icmp3", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "icmp3", "role": "default" }} , 
 	{ "name": "VideoFormat_val", "direction": "in", "datatype": "sc_lv", "bitwidth":5, "type": "signal", "bundle":{"name": "VideoFormat_val", "role": "default" }} , 
 	{ "name": "empty", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "empty", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	Bytes2MultiPixStream_Pipeline_VITIS_LOOP_954_1 {
		trunc_ln941_1 {Type I LastRead 0 FirstWrite -1}
		icmp_ln944 {Type I LastRead 0 FirstWrite -1}
		cmp83_6 {Type I LastRead 0 FirstWrite -1}
		cmp83_5 {Type I LastRead 0 FirstWrite -1}
		cmp83_4 {Type I LastRead 0 FirstWrite -1}
		icmp6 {Type I LastRead 0 FirstWrite -1}
		cmp83_2 {Type I LastRead 0 FirstWrite -1}
		sub79 {Type I LastRead 0 FirstWrite -1}
		img {Type O LastRead -1 FirstWrite 1}
		icmp3 {Type I LastRead 0 FirstWrite -1}
		bytePlanes_plane0 {Type I LastRead 1 FirstWrite -1}
		VideoFormat_val {Type I LastRead 0 FirstWrite -1}
		empty {Type I LastRead 0 FirstWrite -1}
		bytePlanes_plane1 {Type I LastRead 1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2", "Max" : "23042"}
	, {"Name" : "Interval", "Min" : "2", "Max" : "23042"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	trunc_ln941_1 { ap_stable {  { trunc_ln941_1 in_data 0 12 } } }
	icmp_ln944 { ap_stable {  { icmp_ln944 in_data 0 1 } } }
	cmp83_6 { ap_stable {  { cmp83_6 in_data 0 1 } } }
	cmp83_5 { ap_stable {  { cmp83_5 in_data 0 1 } } }
	cmp83_4 { ap_stable {  { cmp83_4 in_data 0 1 } } }
	icmp6 { ap_stable {  { icmp6 in_data 0 1 } } }
	cmp83_2 { ap_stable {  { cmp83_2 in_data 0 1 } } }
	sub79 { ap_stable {  { sub79 in_data 0 13 } } }
	img { ap_fifo {  { img_din fifo_data_in 1 24 }  { img_full_n fifo_status 0 1 }  { img_write fifo_port_we 1 1 }  { img_num_data_valid fifo_status_num_data_valid 0 32 }  { img_fifo_cap fifo_update 0 32 } } }
	icmp3 { ap_stable {  { icmp3 in_data 0 1 } } }
	bytePlanes_plane0 { ap_fifo {  { bytePlanes_plane0_dout fifo_data_in 0 64 }  { bytePlanes_plane0_empty_n fifo_status 0 1 }  { bytePlanes_plane0_read fifo_port_we 1 1 }  { bytePlanes_plane0_num_data_valid fifo_status_num_data_valid 0 11 }  { bytePlanes_plane0_fifo_cap fifo_update 0 11 } } }
	VideoFormat_val { ap_stable {  { VideoFormat_val in_data 0 5 } } }
	empty { ap_none {  { empty in_data 0 1 } } }
	bytePlanes_plane1 { ap_fifo {  { bytePlanes_plane1_dout fifo_data_in 0 64 }  { bytePlanes_plane1_empty_n fifo_status 0 1 }  { bytePlanes_plane1_read fifo_port_we 1 1 }  { bytePlanes_plane1_num_data_valid fifo_status_num_data_valid 0 11 }  { bytePlanes_plane1_fifo_cap fifo_update 0 11 } } }
}
