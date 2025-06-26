####################################################
# Sources
####################################################

set script_dir(main) [file dirname [info script]]

source $script_dir(main)/project.tcl

####################################################
# Build
####################################################

# Create the project
create_project -f $project_name $project_directory -part $fpga_part

if {[info exists verilog_defines]} {
    set_property verilog_define $verilog_defines [current_fileset]
    set_property verilog_define $verilog_defines [get_filesets sim_1]
}
if {[info exists verilog_files]} {
    foreach verilog_file $verilog_files {
        set ext [file extension $verilog_file]
        if {$ext eq ".sv"} {
            puts "Add System Verilog file: $verilog_file"
            read_verilog -sv $verilog_file
        } elseif {$ext eq ".v"} {
            puts "Add Verilog file: $verilog_file"
            read_verilog $verilog_file
        } else {
            error "Invalid file extension: $verilog_file"
            exit
        }
    }
}
if {[info exists tcl_files]} {
    foreach tcl_file $tcl_files {
        puts "Add TCL file: $tcl_file"
        source $tcl_file
    }
}
if {[info exists xdc_files]} {
    foreach xdc_file $xdc_files {
        puts "Add Constraint file: $xdc_file"
        read_xdc [subst $xdc_file]
    }
}


set_property top $top_level [current_fileset]
set_property top $top_level [get_filesets sim_1]


update_compile_order -fileset sources_1
