# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "PIXEL_FORMAT" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "USE_ALPHA" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "USE_PLL" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "CLKIN_PERIOD" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CLK_PATTERN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TX_SWAP_MASK" -parent ${Page_0}


}

proc update_PARAM_VALUE.CLKIN_PERIOD { PARAM_VALUE.CLKIN_PERIOD } {
	# Procedure called to update CLKIN_PERIOD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLKIN_PERIOD { PARAM_VALUE.CLKIN_PERIOD } {
	# Procedure called to validate CLKIN_PERIOD
	return true
}

proc update_PARAM_VALUE.CLK_PATTERN { PARAM_VALUE.CLK_PATTERN } {
	# Procedure called to update CLK_PATTERN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLK_PATTERN { PARAM_VALUE.CLK_PATTERN } {
	# Procedure called to validate CLK_PATTERN
	return true
}

proc update_PARAM_VALUE.PIXEL_FORMAT { PARAM_VALUE.PIXEL_FORMAT } {
	# Procedure called to update PIXEL_FORMAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PIXEL_FORMAT { PARAM_VALUE.PIXEL_FORMAT } {
	# Procedure called to validate PIXEL_FORMAT
	return true
}

proc update_PARAM_VALUE.TX_SWAP_MASK { PARAM_VALUE.TX_SWAP_MASK } {
	# Procedure called to update TX_SWAP_MASK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TX_SWAP_MASK { PARAM_VALUE.TX_SWAP_MASK } {
	# Procedure called to validate TX_SWAP_MASK
	return true
}

proc update_PARAM_VALUE.USE_ALPHA { PARAM_VALUE.USE_ALPHA } {
	# Procedure called to update USE_ALPHA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.USE_ALPHA { PARAM_VALUE.USE_ALPHA } {
	# Procedure called to validate USE_ALPHA
	return true
}

proc update_PARAM_VALUE.USE_PLL { PARAM_VALUE.USE_PLL } {
	# Procedure called to update USE_PLL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.USE_PLL { PARAM_VALUE.USE_PLL } {
	# Procedure called to validate USE_PLL
	return true
}


proc update_MODELPARAM_VALUE.CLKIN_PERIOD { MODELPARAM_VALUE.CLKIN_PERIOD PARAM_VALUE.CLKIN_PERIOD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLKIN_PERIOD}] ${MODELPARAM_VALUE.CLKIN_PERIOD}
}

proc update_MODELPARAM_VALUE.USE_PLL { MODELPARAM_VALUE.USE_PLL PARAM_VALUE.USE_PLL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.USE_PLL}] ${MODELPARAM_VALUE.USE_PLL}
}

proc update_MODELPARAM_VALUE.CLK_PATTERN { MODELPARAM_VALUE.CLK_PATTERN PARAM_VALUE.CLK_PATTERN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLK_PATTERN}] ${MODELPARAM_VALUE.CLK_PATTERN}
}

proc update_MODELPARAM_VALUE.TX_SWAP_MASK { MODELPARAM_VALUE.TX_SWAP_MASK PARAM_VALUE.TX_SWAP_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TX_SWAP_MASK}] ${MODELPARAM_VALUE.TX_SWAP_MASK}
}

proc update_MODELPARAM_VALUE.PIXEL_FORMAT { MODELPARAM_VALUE.PIXEL_FORMAT PARAM_VALUE.PIXEL_FORMAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PIXEL_FORMAT}] ${MODELPARAM_VALUE.PIXEL_FORMAT}
}

proc update_MODELPARAM_VALUE.USE_ALPHA { MODELPARAM_VALUE.USE_ALPHA PARAM_VALUE.USE_ALPHA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.USE_ALPHA}] ${MODELPARAM_VALUE.USE_ALPHA}
}

