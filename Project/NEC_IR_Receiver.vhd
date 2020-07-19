-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 17.0.0 Build 595 04/25/2017 SJ Lite Edition"
-- CREATED		"Fri Jul 10 18:46:15 2020"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY NEC_IR_Receiver IS 
	PORT
	(
		clock50MHz :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		ready :  IN  STD_LOGIC;
		IR_in :  IN  STD_LOGIC;
		available :  OUT  STD_LOGIC;
		address :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		data :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END NEC_IR_Receiver;

ARCHITECTURE bdf_type OF NEC_IR_Receiver IS 

COMPONENT shiftregister
	PORT(d_in : IN STD_LOGIC;
		 sys_clk : IN STD_LOGIC;
		 clear : IN STD_LOGIC;
		 shift : IN STD_LOGIC;
		 d_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT timevalidator
GENERIC (maxTime : INTEGER;
			minTime : INTEGER
			);
	PORT(d_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 valid : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT recmod32counter
	PORT(clear : IN STD_LOGIC;
		 sys_clk : IN STD_LOGIC;
		 cnt : IN STD_LOGIC;
		 last : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT wdt
	PORT(clear : IN STD_LOGIC;
		 sys_clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 nWDTR : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mealy_controller_receiver
	PORT(IR_in : IN STD_LOGIC;
		 last : IN STD_LOGIC;
		 short : IN STD_LOGIC;
		 long : IN STD_LOGIC;
		 b_short : IN STD_LOGIC;
		 b_long : IN STD_LOGIC;
		 valid : IN STD_LOGIC;
		 sys_clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 ready : IN STD_LOGIC;
		 clear : OUT STD_LOGIC;
		 shift : OUT STD_LOGIC;
		 D_shift : OUT STD_LOGIC;
		 t_clear : OUT STD_LOGIC;
		 cnt : OUT STD_LOGIC;
		 available : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT datacollector
	PORT(d_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 valid : OUT STD_LOGIC;
		 address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT clockdivider
	PORT(clk50MHz : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 sys_clk : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT pulsetimer
	PORT(t_clear : IN STD_LOGIC;
		 sys_clk : IN STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	b_long :  STD_LOGIC;
SIGNAL	b_short :  STD_LOGIC;
SIGNAL	clear :  STD_LOGIC;
SIGNAL	clk50MHz :  STD_LOGIC;
SIGNAL	cnt :  STD_LOGIC;
SIGNAL	D_shift :  STD_LOGIC;
SIGNAL	last :  STD_LOGIC;
SIGNAL	long :  STD_LOGIC;
SIGNAL	nWDTR :  STD_LOGIC;
SIGNAL	shift :  STD_LOGIC;
SIGNAL	short :  STD_LOGIC;
SIGNAL	sys_clk :  STD_LOGIC;
SIGNAL	t_clear :  STD_LOGIC;
SIGNAL	valid :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN 



b2v_inst : shiftregister
PORT MAP(d_in => D_shift,
		 sys_clk => sys_clk,
		 clear => clear,
		 shift => shift,
		 d_out => SYNTHESIZED_WIRE_3);


SYNTHESIZED_WIRE_2 <= nWDTR AND nrst;


b2v_inst10 : timevalidator
GENERIC MAP(maxTime => 61,
			minTime => 49
			)
PORT MAP(d_in => SYNTHESIZED_WIRE_6,
		 valid => short);


b2v_inst11 : timevalidator
GENERIC MAP(maxTime => 966,
			minTime => 790
			)
PORT MAP(d_in => SYNTHESIZED_WIRE_6,
		 valid => b_long);


b2v_inst14 : recmod32counter
PORT MAP(clear => clear,
		 sys_clk => sys_clk,
		 cnt => cnt,
		 last => last);


b2v_inst2 : wdt
PORT MAP(clear => t_clear,
		 sys_clk => sys_clk,
		 nrst => nrst,
		 nWDTR => nWDTR);


b2v_inst3 : mealy_controller_receiver
PORT MAP(IR_in => IR_in,
		 last => last,
		 short => short,
		 long => long,
		 b_short => b_short,
		 b_long => b_long,
		 valid => valid,
		 sys_clk => sys_clk,
		 nrst => SYNTHESIZED_WIRE_2,
		 ready => ready,
		 clear => clear,
		 shift => shift,
		 D_shift => D_shift,
		 t_clear => t_clear,
		 cnt => cnt,
		 available => available);


b2v_inst4 : datacollector
PORT MAP(d_in => SYNTHESIZED_WIRE_3,
		 valid => valid,
		 address => address,
		 data => data);


b2v_inst5 : clockdivider
PORT MAP(clk50MHz => clk50MHz,
		 nrst => nrst,
		 sys_clk => sys_clk);


b2v_inst7 : pulsetimer
PORT MAP(t_clear => t_clear,
		 sys_clk => sys_clk,
		 dout => SYNTHESIZED_WIRE_6);


b2v_inst8 : timevalidator
GENERIC MAP(maxTime => 483,
			minTime => 395
			)
PORT MAP(d_in => SYNTHESIZED_WIRE_6,
		 valid => b_short);


b2v_inst9 : timevalidator
GENERIC MAP(maxTime => 182,
			minTime => 148
			)
PORT MAP(d_in => SYNTHESIZED_WIRE_6,
		 valid => long);

clk50MHz <= clock50MHz;

END bdf_type;