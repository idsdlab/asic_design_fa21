###################################################################

# Created by write_sdc on Thu Sep  9 17:08:44 2021

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports clk]  -period 10  -waveform {5 10}

