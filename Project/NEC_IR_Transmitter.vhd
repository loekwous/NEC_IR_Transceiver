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
-- CREATED		"Fri Jul 10 01:05:15 2020"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY NEC_IR_Transmitter IS 
	PORT
	(
		clock50MHz :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		available :  IN  STD_LOGIC;
		Address :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		Data :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		IR_OUT :  OUT  STD_LOGIC;
		ready :  OUT  STD_LOGIC
	);
END NEC_IR_Transmitter;

ARCHITECTURE bdf_type OF NEC_IR_Transmitter IS 

COMPONENT register32bit
	PORT(clk : IN STD_LOGIC;
		 set : IN STD_LOGIC;
		 clear : IN STD_LOGIC;
		 Data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mod32counter
	PORT(enable : IN STD_LOGIC;
		 clear : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 last : OUT STD_LOGIC;
		 output : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT muxcustom
	PORT(Data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 output : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT mealy_controller
	PORT(d_bit : IN STD_LOGIC;
		 last : IN STD_LOGIC;
		 short : IN STD_LOGIC;
		 long : IN STD_LOGIC;
		 b_short : IN STD_LOGIC;
		 b_long : IN STD_LOGIC;
		 sys_clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 available : IN STD_LOGIC;
		 clear : OUT STD_LOGIC;
		 s_enable : OUT STD_LOGIC;
		 r_set : OUT STD_LOGIC;
		 t_clear : OUT STD_LOGIC;
		 c_out : OUT STD_LOGIC;
		 ready : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT clockdivider
	PORT(clk50MHz : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 sys_clk : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT clockmodulator
	PORT(clk50MHz : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 data : IN STD_LOGIC;
		 modOut : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT limitedcounter
	PORT(clear : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 short : OUT STD_LOGIC;
		 long : OUT STD_LOGIC;
		 b_short : OUT STD_LOGIC;
		 b_long : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT dataformatter
	PORT(Address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 Data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	b_long :  STD_LOGIC;
SIGNAL	b_short :  STD_LOGIC;
SIGNAL	c_out :  STD_LOGIC;
SIGNAL	clear :  STD_LOGIC;
SIGNAL	clk50MHz :  STD_LOGIC;
SIGNAL	d_bit :  STD_LOGIC;
SIGNAL	format_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	long :  STD_LOGIC;
SIGNAL	r_set :  STD_LOGIC;
SIGNAL	reg_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	s_enable :  STD_LOGIC;
SIGNAL	s_last :  STD_LOGIC;
SIGNAL	sel :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	short :  STD_LOGIC;
SIGNAL	sys_clk :  STD_LOGIC;
SIGNAL	t_clear :  STD_LOGIC;


BEGIN 



b2v_inst : register32bit
PORT MAP(clk => sys_clk,
		 set => r_set,
		 clear => clear,
		 Data => format_out,
		 output => reg_out);


b2v_inst11 : mod32counter
PORT MAP(enable => s_enable,
		 clear => clear,
		 clk => sys_clk,
		 last => s_last,
		 output => sel);


b2v_inst13 : muxcustom
PORT MAP(Data => reg_out,
		 sel => sel,
		 output => d_bit);


b2v_inst14 : mealy_controller
PORT MAP(d_bit => d_bit,
		 last => s_last,
		 short => short,
		 long => long,
		 b_short => b_short,
		 b_long => b_long,
		 sys_clk => sys_clk,
		 nrst => nrst,
		 available => available,
		 clear => clear,
		 s_enable => s_enable,
		 r_set => r_set,
		 t_clear => t_clear,
		 c_out => c_out,
		 ready => ready);


b2v_inst15 : clockdivider
PORT MAP(clk50MHz => clk50MHz,
		 nrst => nrst,
		 sys_clk => sys_clk);


b2v_inst17 : clockmodulator
PORT MAP(clk50MHz => clk50MHz,
		 nrst => nrst,
		 data => c_out,
		 modOut => IR_OUT);


b2v_inst18 : limitedcounter
PORT MAP(clear => t_clear,
		 clk => sys_clk,
		 short => short,
		 long => long,
		 b_short => b_short,
		 b_long => b_long);


b2v_inst8 : dataformatter
PORT MAP(Address => Address,
		 Data => Data,
		 output => format_out);

clk50MHz <= clock50MHz;

END bdf_type;