file mkdir output

set top_design not_with_dff

read_ddc ../../syn/output/$top_design.mapped.ddc

link

current_design

read_sdc -echo ./sdc/$top_design.sdc

update_timing -full

check_timing -verbose

report_analysis_coverage

write_sdf ./output/$top_design.sdf_pt

