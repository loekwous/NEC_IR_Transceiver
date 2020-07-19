restart -f

force clock50MHz 0 0, 1 10 -rep 20
force nrst 1 1, 0 1000, 1 3000

# For receiver

force ready 0 0, 1 81000000

# Send burst
force IR_in 0
run 10000000
force IR_in 1
run 9000000
force IR_in 0
run 4500000

# Send address 0xF0F0
#first nibble

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

#second nibble

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

#third nibble

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

#fourth nibble

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

#send Data 0x00

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

force IR_in 1
run 563000
force IR_in 0
run 563000

# Send inverse of data 0xFF

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

force IR_in 1
run 563000
force IR_in 0
run 1690000

run 10000