
####################################################################
# Specify Path
####################################################################

set script_dir(project) [file dirname [info script]]

set src_dir $script_dir(project)/../src
set constr_dir $script_dir(project)/../constr
set ip_dir $script_dir(project)/../ip

####################################################################
# Project Settings
####################################################################

set project_directory "workspace/emu"
set project_name      "emu"
set board_part        "FM-CS-XCVP1902-R2"
set fpga_part         "xcvp1902-vsva6865-2MP-e-S"
set top_level         "top_fpga"
set verilog_defines   "AMD=1"

####################################################################
# Project Files
####################################################################

set verilog_files [concat \
    $src_dir/top_fpga.sv \
]


set tcl_files [list \
    $ip_dir/cips_io.tcl \
]


set xdc_files [concat \
    $constr_dir/top_fpga_io.xdc \
]

