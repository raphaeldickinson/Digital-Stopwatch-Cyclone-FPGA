#################################################################################
#Useful manual: https://www.microsemi.com/document-portal/doc_view/136364-modelsim-me-10-4c-command-reference-manual-for-libero-soc-v11-7
#################################################################################
vsim work.stopWatch_tb
restart -f
delete wave *

radix define States {
    4'b0000 "RESET"   -color red,
    4'b0001 "STOP"   -color red,
    4'b0010 "S2RES"   -color red,
    4'b0011 "S2R"   -color red,
    4'b0100 "RUN"   -color yellow,
    4'b0101 "R2LR"   -color yellow,
    4'b0110 "R2S"   -color yellow,
    4'b0111 "INC"   -color yellow,
    4'b1000 "LAPRUN"   -color orange,
    4'b1001 "LR2R"   -color orange,
    4'b1010 "LR2LS"   -color orange,
    4'b1011 "LAPINC"   -color orange,
    4'b1100 "LAPSTOP"   -color green,
    4'b1101 "LS2R"   -color green,
    4'b1110 "LS2LR"   -color green,

    -default hex
    -defaultcolor white
}

restart -f
delete wave *

add wave -position end  sim:/stopWatch_tb/uut/clk
add wave -position end  sim:/stopWatch_tb/uut/resetn

add wave -position end  -radix States sim:/stopWatch_tb/uut/cpsw/state

add wave -position end  -radix hex -color yellow sim:/stopWatch_tb/uut/cw
add wave -position end 		   -color yellow  sim:/stopWatch_tb/uut/dpsw/tenth
add wave -position end 		   -color yellow  sim:/stopWatch_tb/uut/S1
add wave -position end 		   -color yellow sim:/stopWatch_tb/uut/S2

add wave -position end  -radix hex -color red sim:/stopWatch_tb/uut/dpsw/clkCount

add wave -position end  -radix hex -color orange sim:/stopWatch_tb/uut/dpsw/tenthDigit
add wave -position end  -radix hex -color green sim:/stopWatch_tb/uut/dpsw/tenthDisp
add wave -position end  -radix hex -color orange sim:/stopWatch_tb/uut/dpsw/unitDigit
add wave -position end  -radix hex -color green sim:/stopWatch_tb/uut/dpsw/unitDisp
add wave -position end  -radix hex -color orange sim:/stopWatch_tb/uut/dpsw/unitDigit
add wave -position end  -radix hex -color green sim:/stopWatch_tb/uut/dpsw/tenDisp






