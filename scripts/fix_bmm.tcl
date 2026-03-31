set bmm_path "[get_property DIRECTORY [current_project]]/OSDZU3_Ref_Design.gen/sources_1/bd/design_1tee/design_1tee.bmm"
if {[file exists $bmm_path]} {
    set fp [open $bmm_path r]
    set content [read $fp]
    close $fp
    set modified 0
    if {[string match *act_bram* $content]} {
        regsub -all {   ADDRESS_SPACE act_bram.*?END_ADDRESS_SPACE;\n} $content {} content
        regsub -all {DEFINE_MEMORY_TYPE act_bram.*?\n} $content {} content
        set modified 1
        puts "BMM: stripped act_bram entries"
    }
    if {$modified} {
        set fp [open $bmm_path w]
        puts $fp $content
        close $fp
    }
}

# Fix BMM_INFO_ADDRESS_SPACE attributes on secondary BRAM controllers
# Vivado incorrectly points dlmb_bram_if_cntlr1 and dlmb_bram_if_cntlr2 to lmb_bram
# instead of their respective lmb_bram1 and lmb_bram2
set synth_v "[get_property DIRECTORY [current_project]]/OSDZU3_Ref_Design.gen/sources_1/bd/design_1tee/synth/design_1tee.v"
if {[file exists $synth_v]} {
    set fp [open $synth_v r]
    set content [read $fp]
    close $fp
    set orig $content
    # Fix dlmb_bram_if_cntlr1: should point to lmb_bram1
    regsub {BMM_INFO_ADDRESS_SPACE = "byte  0x00000000 32 > design_1tee lmb_bram" \*\)\s*\(\* KEEP_HIERARCHY = "YES" \*\)\s*design_1tee_dlmb_bram_if_cntlr_1 dlmb_bram_if_cntlr1} $content {BMM_INFO_ADDRESS_SPACE = "byte  0x00000000 32 > design_1tee lmb_bram1" *)\n  (* KEEP_HIERARCHY = "YES" *)\n  design_1tee_dlmb_bram_if_cntlr_1 dlmb_bram_if_cntlr1} content
    # Fix dlmb_bram_if_cntlr2: should point to lmb_bram2
    regsub {BMM_INFO_ADDRESS_SPACE = "byte  0x00000000 32 > design_1tee lmb_bram" \*\)\s*\(\* KEEP_HIERARCHY = "YES" \*\)\s*design_1tee_dlmb_bram_if_cntlr1_0 dlmb_bram_if_cntlr2} $content {BMM_INFO_ADDRESS_SPACE = "byte  0x00000000 32 > design_1tee lmb_bram2" *)\n  (* KEEP_HIERARCHY = "YES" *)\n  design_1tee_dlmb_bram_if_cntlr1_0 dlmb_bram_if_cntlr2} content
    if {$content ne $orig} {
        set fp [open $synth_v w]
        puts -nonewline $fp $content
        close $fp
        puts "BMM: fixed BMM_INFO_ADDRESS_SPACE on secondary BRAM controllers"
    }
}
