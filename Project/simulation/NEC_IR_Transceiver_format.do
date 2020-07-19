onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /nec_ir_transceiver/clk
add wave -noupdate /nec_ir_transceiver/nrst
add wave -noupdate -divider {Transmitter Data}
add wave -noupdate /nec_ir_transceiver/i_address
add wave -noupdate /nec_ir_transceiver/i_data
add wave -noupdate -divider {Transmitter Control}
add wave -noupdate /nec_ir_transceiver/i_available
add wave -noupdate /nec_ir_transceiver/i_ready
add wave -noupdate -divider {Transmitter IR}
add wave -noupdate /nec_ir_transceiver/IR_OUT
add wave -noupdate -divider {Receiver Data}
add wave -noupdate /nec_ir_transceiver/o_address
add wave -noupdate /nec_ir_transceiver/o_data
add wave -noupdate -divider {Receiver Control}
add wave -noupdate /nec_ir_transceiver/o_available
add wave -noupdate /nec_ir_transceiver/o_ready
add wave -noupdate -divider {Receiver IR}
add wave -noupdate /nec_ir_transceiver/IR_IN
add wave -noupdate -divider Other
add wave -noupdate /nec_ir_transceiver/b2v_inst/b2v_inst3/present_state
add wave -noupdate /nec_ir_transceiver/b2v_inst/b2v_inst2/nWDTR
add wave -noupdate /nec_ir_transceiver/b2v_inst/last
add wave -noupdate /nec_ir_transceiver/b2v_inst/b2v_inst14/counter
add wave -noupdate /nec_ir_transceiver/b2v_inst/valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {76405354 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 337
configure wave -valuecolwidth 115
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
WaveRestoreZoom {43710106 ns} {150392114 ns}
