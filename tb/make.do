transcript on


vlib work

vlog -sv ../src/bit_population_counter.sv
vlog -sv ./bit_population_counter_tb.sv

vsim -novopt bit_population_counter_tb

add wave /bit_population_counter_tb/clk
add wave /bit_population_counter_tb/rst
add wave /bit_population_counter_tb/data_val_i
add wave /bit_population_counter_tb/data_i
add wave /bit_population_counter_tb/data_val_o
add wave -radix hex /bit_population_counter_tb/data_o

run -all

