onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /nec_ir_transceiver/clock50MHz
add wave -noupdate /nec_ir_transceiver/sys_clk
add wave -noupdate /nec_ir_transceiver/nrst
add wave -noupdate -divider Data
add wave -noupdate -radix hexadecimal /nec_ir_transceiver/Address
add wave -noupdate -radix hexadecimal /nec_ir_transceiver/Data
add wave -noupdate -divider {External Control}
add wave -noupdate /nec_ir_transceiver/available
add wave -noupdate /nec_ir_transceiver/ready
add wave -noupdate -divider {Internal Control}
add wave -noupdate /nec_ir_transceiver/clear
add wave -noupdate /nec_ir_transceiver/t_clear
add wave -noupdate /nec_ir_transceiver/d_bit
add wave -noupdate /nec_ir_transceiver/s_last
add wave -noupdate /nec_ir_transceiver/s_enable
add wave -noupdate /nec_ir_transceiver/r_set
add wave -noupdate /nec_ir_transceiver/c_out
add wave -noupdate -divider Timing
add wave -noupdate /nec_ir_transceiver/short
add wave -noupdate /nec_ir_transceiver/long
add wave -noupdate /nec_ir_transceiver/b_short
add wave -noupdate /nec_ir_transceiver/b_long
add wave -noupdate -divider States
add wave -noupdate /nec_ir_transceiver/b2v_inst1/next_state
add wave -noupdate /nec_ir_transceiver/b2v_inst1/present_state
add wave -noupdate -divider {Internal Data}
add wave -noupdate -radix hexadecimal /nec_ir_transceiver/format_out
add wave -noupdate -radix hexadecimal /nec_ir_transceiver/reg_out
add wave -noupdate -radix hexadecimal /nec_ir_transceiver/sel
add wave -noupdate /nec_ir_transceiver/b2v_inst7/counter
add wave -noupdate -divider Outputs
add wave -noupdate /nec_ir_transceiver/IR_OUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1136650 ns} 0} {{Cursor 3} {10260 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 277
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {8528111 ns}
