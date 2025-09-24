set moduleName v_mix_422_to_444_true_Pipeline_VITIS_LOOP_161_2
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
set cdfgNum 53
set C_modelName {v_mix_422_to_444<true>_Pipeline_VITIS_LOOP_161_2}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ p_0_0_0206358_lcssa364426 int 8 regular  }
	{ p_0_0_0_0_0207_4_lcssa423 int 8 regular  }
	{ p_0_0_0_0_0207_3_lcssa420 int 8 regular  }
	{ p_0_0_0_0_0207_2_lcssa417 int 8 regular  }
	{ p_0_0_0206358_lcssa409 int 8 regular  }
	{ loopWidth int 16 regular {ap_stable 0} }
	{ srcLayer1Yuv int 24 regular {fifo 1 volatile }  }
	{ width int 16 regular {ap_stable 0} }
	{ srcLayer1Yuv422 int 24 regular {fifo 0 volatile }  }
	{ p_0_0_0199355390_out int 8 regular {pointer 2}  }
	{ p_0_0_0200353387_out int 8 regular {pointer 2}  }
	{ p_0_0_0_0_0_2384_out int 8 regular {pointer 2}  }
	{ p_0_0_0_0_0205_2381_out int 8 regular {pointer 2}  }
	{ p_0_0_0_0_0_1374_out int 8 regular {pointer 2}  }
	{ p_0_0_0_0_0205_1367_out int 8 regular {pointer 2}  }
	{ p_0_0_0206358363_out int 8 regular {pointer 1}  }
	{ p_0_0_0_0_0207_4362_out int 8 regular {pointer 1}  }
	{ p_0_0_0_0_0207_3361_out int 8 regular {pointer 1}  }
	{ p_0_0_0_0_0207_2360_out int 8 regular {pointer 1}  }
	{ p_0_0_0_0_0207_1359_out int 8 regular {pointer 2}  }
	{ p_0_0_0199354_out int 8 regular {pointer 2}  }
	{ p_0_0_0200352_out int 8 regular {pointer 2}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "p_0_0_0206358_lcssa364426", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_0_0_0_0_0207_4_lcssa423", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_0_0_0_0_0207_3_lcssa420", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_0_0_0_0_0207_2_lcssa417", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "p_0_0_0206358_lcssa409", "interface" : "wire", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "loopWidth", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "srcLayer1Yuv", "interface" : "fifo", "bitwidth" : 24, "direction" : "WRITEONLY"} , 
 	{ "Name" : "width", "interface" : "wire", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "srcLayer1Yuv422", "interface" : "fifo", "bitwidth" : 24, "direction" : "READONLY"} , 
 	{ "Name" : "p_0_0_0199355390_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} , 
 	{ "Name" : "p_0_0_0200353387_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} , 
 	{ "Name" : "p_0_0_0_0_0_2384_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} , 
 	{ "Name" : "p_0_0_0_0_0205_2381_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} , 
 	{ "Name" : "p_0_0_0_0_0_1374_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} , 
 	{ "Name" : "p_0_0_0_0_0205_1367_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} , 
 	{ "Name" : "p_0_0_0206358363_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "p_0_0_0_0_0207_4362_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "p_0_0_0_0_0207_3361_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "p_0_0_0_0_0207_2360_out", "interface" : "wire", "bitwidth" : 8, "direction" : "WRITEONLY"} , 
 	{ "Name" : "p_0_0_0_0_0207_1359_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} , 
 	{ "Name" : "p_0_0_0199354_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} , 
 	{ "Name" : "p_0_0_0200352_out", "interface" : "wire", "bitwidth" : 8, "direction" : "READWRITE"} ]}
# RTL Port declarations: 
set portNum 58
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ srcLayer1Yuv422_dout sc_in sc_lv 24 signal 8 } 
	{ srcLayer1Yuv422_empty_n sc_in sc_logic 1 signal 8 } 
	{ srcLayer1Yuv422_read sc_out sc_logic 1 signal 8 } 
	{ srcLayer1Yuv422_num_data_valid sc_in sc_lv 3 signal 8 } 
	{ srcLayer1Yuv422_fifo_cap sc_in sc_lv 3 signal 8 } 
	{ srcLayer1Yuv_din sc_out sc_lv 24 signal 6 } 
	{ srcLayer1Yuv_full_n sc_in sc_logic 1 signal 6 } 
	{ srcLayer1Yuv_write sc_out sc_logic 1 signal 6 } 
	{ srcLayer1Yuv_num_data_valid sc_in sc_lv 32 signal 6 } 
	{ srcLayer1Yuv_fifo_cap sc_in sc_lv 32 signal 6 } 
	{ p_0_0_0206358_lcssa364426 sc_in sc_lv 8 signal 0 } 
	{ p_0_0_0_0_0207_4_lcssa423 sc_in sc_lv 8 signal 1 } 
	{ p_0_0_0_0_0207_3_lcssa420 sc_in sc_lv 8 signal 2 } 
	{ p_0_0_0_0_0207_2_lcssa417 sc_in sc_lv 8 signal 3 } 
	{ p_0_0_0206358_lcssa409 sc_in sc_lv 8 signal 4 } 
	{ loopWidth sc_in sc_lv 16 signal 5 } 
	{ width sc_in sc_lv 16 signal 7 } 
	{ p_0_0_0199355390_out_i sc_in sc_lv 8 signal 9 } 
	{ p_0_0_0199355390_out_o sc_out sc_lv 8 signal 9 } 
	{ p_0_0_0199355390_out_o_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ p_0_0_0200353387_out_i sc_in sc_lv 8 signal 10 } 
	{ p_0_0_0200353387_out_o sc_out sc_lv 8 signal 10 } 
	{ p_0_0_0200353387_out_o_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ p_0_0_0_0_0_2384_out_i sc_in sc_lv 8 signal 11 } 
	{ p_0_0_0_0_0_2384_out_o sc_out sc_lv 8 signal 11 } 
	{ p_0_0_0_0_0_2384_out_o_ap_vld sc_out sc_logic 1 outvld 11 } 
	{ p_0_0_0_0_0205_2381_out_i sc_in sc_lv 8 signal 12 } 
	{ p_0_0_0_0_0205_2381_out_o sc_out sc_lv 8 signal 12 } 
	{ p_0_0_0_0_0205_2381_out_o_ap_vld sc_out sc_logic 1 outvld 12 } 
	{ p_0_0_0_0_0_1374_out_i sc_in sc_lv 8 signal 13 } 
	{ p_0_0_0_0_0_1374_out_o sc_out sc_lv 8 signal 13 } 
	{ p_0_0_0_0_0_1374_out_o_ap_vld sc_out sc_logic 1 outvld 13 } 
	{ p_0_0_0_0_0205_1367_out_i sc_in sc_lv 8 signal 14 } 
	{ p_0_0_0_0_0205_1367_out_o sc_out sc_lv 8 signal 14 } 
	{ p_0_0_0_0_0205_1367_out_o_ap_vld sc_out sc_logic 1 outvld 14 } 
	{ p_0_0_0206358363_out sc_out sc_lv 8 signal 15 } 
	{ p_0_0_0206358363_out_ap_vld sc_out sc_logic 1 outvld 15 } 
	{ p_0_0_0_0_0207_4362_out sc_out sc_lv 8 signal 16 } 
	{ p_0_0_0_0_0207_4362_out_ap_vld sc_out sc_logic 1 outvld 16 } 
	{ p_0_0_0_0_0207_3361_out sc_out sc_lv 8 signal 17 } 
	{ p_0_0_0_0_0207_3361_out_ap_vld sc_out sc_logic 1 outvld 17 } 
	{ p_0_0_0_0_0207_2360_out sc_out sc_lv 8 signal 18 } 
	{ p_0_0_0_0_0207_2360_out_ap_vld sc_out sc_logic 1 outvld 18 } 
	{ p_0_0_0_0_0207_1359_out_i sc_in sc_lv 8 signal 19 } 
	{ p_0_0_0_0_0207_1359_out_o sc_out sc_lv 8 signal 19 } 
	{ p_0_0_0_0_0207_1359_out_o_ap_vld sc_out sc_logic 1 outvld 19 } 
	{ p_0_0_0199354_out_i sc_in sc_lv 8 signal 20 } 
	{ p_0_0_0199354_out_o sc_out sc_lv 8 signal 20 } 
	{ p_0_0_0199354_out_o_ap_vld sc_out sc_logic 1 outvld 20 } 
	{ p_0_0_0200352_out_i sc_in sc_lv 8 signal 21 } 
	{ p_0_0_0200352_out_o sc_out sc_lv 8 signal 21 } 
	{ p_0_0_0200352_out_o_ap_vld sc_out sc_logic 1 outvld 21 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "srcLayer1Yuv422_dout", "direction": "in", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "dout" }} , 
 	{ "name": "srcLayer1Yuv422_empty_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "empty_n" }} , 
 	{ "name": "srcLayer1Yuv422_read", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "read" }} , 
 	{ "name": "srcLayer1Yuv422_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "num_data_valid" }} , 
 	{ "name": "srcLayer1Yuv422_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":3, "type": "signal", "bundle":{"name": "srcLayer1Yuv422", "role": "fifo_cap" }} , 
 	{ "name": "srcLayer1Yuv_din", "direction": "out", "datatype": "sc_lv", "bitwidth":24, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "din" }} , 
 	{ "name": "srcLayer1Yuv_full_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "full_n" }} , 
 	{ "name": "srcLayer1Yuv_write", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "write" }} , 
 	{ "name": "srcLayer1Yuv_num_data_valid", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "num_data_valid" }} , 
 	{ "name": "srcLayer1Yuv_fifo_cap", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "srcLayer1Yuv", "role": "fifo_cap" }} , 
 	{ "name": "p_0_0_0206358_lcssa364426", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0206358_lcssa364426", "role": "default" }} , 
 	{ "name": "p_0_0_0_0_0207_4_lcssa423", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0207_4_lcssa423", "role": "default" }} , 
 	{ "name": "p_0_0_0_0_0207_3_lcssa420", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0207_3_lcssa420", "role": "default" }} , 
 	{ "name": "p_0_0_0_0_0207_2_lcssa417", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0207_2_lcssa417", "role": "default" }} , 
 	{ "name": "p_0_0_0206358_lcssa409", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0206358_lcssa409", "role": "default" }} , 
 	{ "name": "loopWidth", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "loopWidth", "role": "default" }} , 
 	{ "name": "width", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "width", "role": "default" }} , 
 	{ "name": "p_0_0_0199355390_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0199355390_out", "role": "i" }} , 
 	{ "name": "p_0_0_0199355390_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0199355390_out", "role": "o" }} , 
 	{ "name": "p_0_0_0199355390_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0199355390_out", "role": "o_ap_vld" }} , 
 	{ "name": "p_0_0_0200353387_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0200353387_out", "role": "i" }} , 
 	{ "name": "p_0_0_0200353387_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0200353387_out", "role": "o" }} , 
 	{ "name": "p_0_0_0200353387_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0200353387_out", "role": "o_ap_vld" }} , 
 	{ "name": "p_0_0_0_0_0_2384_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0_2384_out", "role": "i" }} , 
 	{ "name": "p_0_0_0_0_0_2384_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0_2384_out", "role": "o" }} , 
 	{ "name": "p_0_0_0_0_0_2384_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0_0_0_2384_out", "role": "o_ap_vld" }} , 
 	{ "name": "p_0_0_0_0_0205_2381_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0205_2381_out", "role": "i" }} , 
 	{ "name": "p_0_0_0_0_0205_2381_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0205_2381_out", "role": "o" }} , 
 	{ "name": "p_0_0_0_0_0205_2381_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0_0_0205_2381_out", "role": "o_ap_vld" }} , 
 	{ "name": "p_0_0_0_0_0_1374_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0_1374_out", "role": "i" }} , 
 	{ "name": "p_0_0_0_0_0_1374_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0_1374_out", "role": "o" }} , 
 	{ "name": "p_0_0_0_0_0_1374_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0_0_0_1374_out", "role": "o_ap_vld" }} , 
 	{ "name": "p_0_0_0_0_0205_1367_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0205_1367_out", "role": "i" }} , 
 	{ "name": "p_0_0_0_0_0205_1367_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0205_1367_out", "role": "o" }} , 
 	{ "name": "p_0_0_0_0_0205_1367_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0_0_0205_1367_out", "role": "o_ap_vld" }} , 
 	{ "name": "p_0_0_0206358363_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0206358363_out", "role": "default" }} , 
 	{ "name": "p_0_0_0206358363_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0206358363_out", "role": "ap_vld" }} , 
 	{ "name": "p_0_0_0_0_0207_4362_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0207_4362_out", "role": "default" }} , 
 	{ "name": "p_0_0_0_0_0207_4362_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0_0_0207_4362_out", "role": "ap_vld" }} , 
 	{ "name": "p_0_0_0_0_0207_3361_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0207_3361_out", "role": "default" }} , 
 	{ "name": "p_0_0_0_0_0207_3361_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0_0_0207_3361_out", "role": "ap_vld" }} , 
 	{ "name": "p_0_0_0_0_0207_2360_out", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0207_2360_out", "role": "default" }} , 
 	{ "name": "p_0_0_0_0_0207_2360_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0_0_0207_2360_out", "role": "ap_vld" }} , 
 	{ "name": "p_0_0_0_0_0207_1359_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0207_1359_out", "role": "i" }} , 
 	{ "name": "p_0_0_0_0_0207_1359_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0_0_0207_1359_out", "role": "o" }} , 
 	{ "name": "p_0_0_0_0_0207_1359_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0_0_0207_1359_out", "role": "o_ap_vld" }} , 
 	{ "name": "p_0_0_0199354_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0199354_out", "role": "i" }} , 
 	{ "name": "p_0_0_0199354_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0199354_out", "role": "o" }} , 
 	{ "name": "p_0_0_0199354_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0199354_out", "role": "o_ap_vld" }} , 
 	{ "name": "p_0_0_0200352_out_i", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0200352_out", "role": "i" }} , 
 	{ "name": "p_0_0_0200352_out_o", "direction": "out", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "p_0_0_0200352_out", "role": "o" }} , 
 	{ "name": "p_0_0_0200352_out_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_0_0_0200352_out", "role": "o_ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
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
	{"Name" : "Latency", "Min" : "4", "Max" : "32771"}
	, {"Name" : "Interval", "Min" : "4", "Max" : "32771"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	p_0_0_0206358_lcssa364426 { ap_none {  { p_0_0_0206358_lcssa364426 in_data 0 8 } } }
	p_0_0_0_0_0207_4_lcssa423 { ap_none {  { p_0_0_0_0_0207_4_lcssa423 in_data 0 8 } } }
	p_0_0_0_0_0207_3_lcssa420 { ap_none {  { p_0_0_0_0_0207_3_lcssa420 in_data 0 8 } } }
	p_0_0_0_0_0207_2_lcssa417 { ap_none {  { p_0_0_0_0_0207_2_lcssa417 in_data 0 8 } } }
	p_0_0_0206358_lcssa409 { ap_none {  { p_0_0_0206358_lcssa409 in_data 0 8 } } }
	loopWidth { ap_stable {  { loopWidth in_data 0 16 } } }
	srcLayer1Yuv { ap_fifo {  { srcLayer1Yuv_din fifo_data_in 1 24 }  { srcLayer1Yuv_full_n fifo_status 0 1 }  { srcLayer1Yuv_write fifo_port_we 1 1 }  { srcLayer1Yuv_num_data_valid fifo_status_num_data_valid 0 32 }  { srcLayer1Yuv_fifo_cap fifo_update 0 32 } } }
	width { ap_stable {  { width in_data 0 16 } } }
	srcLayer1Yuv422 { ap_fifo {  { srcLayer1Yuv422_dout fifo_data_in 0 24 }  { srcLayer1Yuv422_empty_n fifo_status 0 1 }  { srcLayer1Yuv422_read fifo_port_we 1 1 }  { srcLayer1Yuv422_num_data_valid fifo_status_num_data_valid 0 3 }  { srcLayer1Yuv422_fifo_cap fifo_update 0 3 } } }
	p_0_0_0199355390_out { ap_ovld {  { p_0_0_0199355390_out_i in_data 0 8 }  { p_0_0_0199355390_out_o out_data 1 8 }  { p_0_0_0199355390_out_o_ap_vld out_vld 1 1 } } }
	p_0_0_0200353387_out { ap_ovld {  { p_0_0_0200353387_out_i in_data 0 8 }  { p_0_0_0200353387_out_o out_data 1 8 }  { p_0_0_0200353387_out_o_ap_vld out_vld 1 1 } } }
	p_0_0_0_0_0_2384_out { ap_ovld {  { p_0_0_0_0_0_2384_out_i in_data 0 8 }  { p_0_0_0_0_0_2384_out_o out_data 1 8 }  { p_0_0_0_0_0_2384_out_o_ap_vld out_vld 1 1 } } }
	p_0_0_0_0_0205_2381_out { ap_ovld {  { p_0_0_0_0_0205_2381_out_i in_data 0 8 }  { p_0_0_0_0_0205_2381_out_o out_data 1 8 }  { p_0_0_0_0_0205_2381_out_o_ap_vld out_vld 1 1 } } }
	p_0_0_0_0_0_1374_out { ap_ovld {  { p_0_0_0_0_0_1374_out_i in_data 0 8 }  { p_0_0_0_0_0_1374_out_o out_data 1 8 }  { p_0_0_0_0_0_1374_out_o_ap_vld out_vld 1 1 } } }
	p_0_0_0_0_0205_1367_out { ap_ovld {  { p_0_0_0_0_0205_1367_out_i in_data 0 8 }  { p_0_0_0_0_0205_1367_out_o out_data 1 8 }  { p_0_0_0_0_0205_1367_out_o_ap_vld out_vld 1 1 } } }
	p_0_0_0206358363_out { ap_vld {  { p_0_0_0206358363_out out_data 1 8 }  { p_0_0_0206358363_out_ap_vld out_vld 1 1 } } }
	p_0_0_0_0_0207_4362_out { ap_vld {  { p_0_0_0_0_0207_4362_out out_data 1 8 }  { p_0_0_0_0_0207_4362_out_ap_vld out_vld 1 1 } } }
	p_0_0_0_0_0207_3361_out { ap_vld {  { p_0_0_0_0_0207_3361_out out_data 1 8 }  { p_0_0_0_0_0207_3361_out_ap_vld out_vld 1 1 } } }
	p_0_0_0_0_0207_2360_out { ap_vld {  { p_0_0_0_0_0207_2360_out out_data 1 8 }  { p_0_0_0_0_0207_2360_out_ap_vld out_vld 1 1 } } }
	p_0_0_0_0_0207_1359_out { ap_ovld {  { p_0_0_0_0_0207_1359_out_i in_data 0 8 }  { p_0_0_0_0_0207_1359_out_o out_data 1 8 }  { p_0_0_0_0_0207_1359_out_o_ap_vld out_vld 1 1 } } }
	p_0_0_0199354_out { ap_ovld {  { p_0_0_0199354_out_i in_data 0 8 }  { p_0_0_0199354_out_o out_data 1 8 }  { p_0_0_0199354_out_o_ap_vld out_vld 1 1 } } }
	p_0_0_0200352_out { ap_ovld {  { p_0_0_0200352_out_i in_data 0 8 }  { p_0_0_0200352_out_o out_data 1 8 }  { p_0_0_0200352_out_o_ap_vld out_vld 1 1 } } }
}
