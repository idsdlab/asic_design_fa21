set top_design not_with_dff
set_svf not_with_dff.svf
define_design_lib work -path ./work

set rtl [ list \
  ../src/rtl/not_with_dff.v \
]

analyze -format verilog $rtl
elaborate -architecture verilog $top_design
#uniquify : uniquify is executed automatically

foreach_in_collection design [ get_designs "*" ] {
    current_design $design
    set_fix_multiple_port_nets -all -buffer_constants
}

#read_ddc ./output/pad_TOP_unmapped.ddc
current_design $top_design

set_fix_multiple_port_nets -all -buffer_constants

redirect -tee -file rpt/0_link.rpt {link}
redirect -tee -file rpt/1_check_design.rpt {check_design}
#write -format ddc -hierarchy -out ./output/pad_TOP_unmapped.ddc

#do "dcprocheck" prior to source the below constraint file
create_clock -period 10 -name clk -waveform {5 10} [get_ports clk]
#redirect -tee -file rpt/2_source.rpt {source -echo -verbose cons/TOP.con}
redirect -tee -file rpt/3_check_timing.rpt {check_timing}
redirect -tee -file rpt/4_report_port.rpt {report_port -verbose}

#set_boundary_optimization $top_design false
redirect -tee -file rpt/5_compile.rpt {compile_ultra -no_autoungroup}
redirect -tee -file rpt/6_report_constraint.rpt {report_constraint -all_violators}
redirect -tee -file rpt/7_report_timing.rpt {report_timing}
redirect -tee -file rpt/8_report_path_group.rpt {report_path_group}
redirect -tee -file rpt/9_report_area.rpt {report_area}
redirect -tee -file rpt/10_report_clock.rpt {report_clock -skew -attr}; #This is for dc_shell-topo

# "tri" to "wire"
set verilogout_no_tri true
# bus[10] to bus_10_
change_names -rules verilog -hierarchy

write -format verilog -hierarchy -output ./output/$top_design.gate.v
write -format ddc -hierarchy -output ./output/$top_design.mapped.ddc
write_sdc -version 2.1 ./output/$top_design.sdc
write_sdf ./output/$top_design.sdf_dc
set_svf -off

quit
