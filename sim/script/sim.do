vlib work
vcom -93 -work work ../../src/SEVENSEG/src/seven_seg_display.vhd
vcom -93 -work work ../../src/seven_seg_counter.vhd
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../../src/generic_adder_beh.vhd
vcom -93 -work work ../src/seven_seg_tb.vhd
vsim -voptargs=+acc seven_seg_tb
do wave.do
run 5000 ns
