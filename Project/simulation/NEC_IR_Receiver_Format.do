onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /nec_ir_receiver/sys_clk
add wave -noupdate /nec_ir_receiver/nrst
add wave -noupdate /nec_ir_receiver/nWDTR
add wave -noupdate -divider Input
add wave -noupdate /nec_ir_receiver/IR_in
add wave -noupdate -divider Timing
add wave -noupdate /nec_ir_receiver/b_long
add wave -noupdate /nec_ir_receiver/b_short
add wave -noupdate /nec_ir_receiver/long
add wave -noupdate /nec_ir_receiver/short
add wave -noupdate -divider Control
add wave -noupdate /nec_ir_receiver/clear
add wave -noupdate /nec_ir_receiver/cnt
add wave -noupdate /nec_ir_receiver/last
add wave -noupdate /nec_ir_receiver/t_clear
add wave -noupdate /nec_ir_receiver/valid
add wave -noupdate -divider {Mealy controller}
add wave -noupdate /nec_ir_receiver/b2v_inst3/next_state
add wave -noupdate /nec_ir_receiver/b2v_inst3/present_state
add wave -noupdate -divider shiftregister
add wave -noupdate /nec_ir_receiver/shift
add wave -noupdate /nec_ir_receiver/D_shift
add wave -noupdate -radix hexadecimal /nec_ir_receiver/b2v_inst/d_out
add wave -noupdate -divider {External control}
add wave -noupdate /nec_ir_receiver/available
add wave -noupdate /nec_ir_receiver/ready
add wave -noupdate -divider Output
add wave -noupdate -radix hexadecimal /nec_ir_receiver/data
add wave -noupdate -radix hexadecimal /nec_ir_receiver/address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8087470 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
configure wave -valuecolwidth 61
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
WaveRestoreZoom {4098890 ns} {76662210 ns}
