restart -f

force clk 0 0, 1 10 -rep 20
force nrst 1 1, 0 1000, 1 3000

# For transmitter
force i_address 16#X 0, 16#00F0 8000, 16#X 1200000, 16#8D72 66000000, 16#X 67000000
force i_data 16#X 0, 16#FE 9000, 16#X 1200000, 16#B1 66000000, 16#X 67000000 
force i_available 0 0, 1 9500, 0 1000000, 1 66100000, 0 66150000

force IR_IN 0 0
force o_ready 0 0

run 40000000