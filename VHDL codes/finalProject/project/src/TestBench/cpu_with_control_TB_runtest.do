SetActiveLib -work
comp -include "$dsn\src\cpu_with_control.vhd" 
comp -include "$dsn\src\TestBench\cpu_with_control_TB.vhd" 
asim +access +r TESTBENCH_FOR_cpu_with_control 
wave 
wave -noreg CLOCK
wave -noreg RST
wave -noreg mem_content
wave -noreg out0
wave -noreg out1
wave -noreg out2
wave -noreg out3
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\cpu_with_control_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_cpu_with_control 
