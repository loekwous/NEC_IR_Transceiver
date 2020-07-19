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
-- CREATED		"Fri Jul 10 18:46:28 2020"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY NEC_IR_Transceiver IS 
	PORT
	(
		IR_IN :  IN  STD_LOGIC;
		o_ready :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		i_available :  IN  STD_LOGIC;
		i_address :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		i_data :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		IR_OUT :  OUT  STD_LOGIC;
		o_available :  OUT  STD_LOGIC;
		i_ready :  OUT  STD_LOGIC;
		o_address :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		o_data :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END NEC_IR_Transceiver;

ARCHITECTURE bdf_type OF NEC_IR_Transceiver IS 

COMPONENT nec_ir_receiver
	PORT(IR_in : IN STD_LOGIC;
		 clock50MHz : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 ready : IN STD_LOGIC;
		 available : OUT STD_LOGIC;
		 address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT nec_ir_transmitter
	PORT(clock50MHz : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 available : IN STD_LOGIC;
		 Address : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 Data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 IR_OUT : OUT STD_LOGIC;
		 ready : OUT STD_LOGIC
	);
END COMPONENT;



BEGIN 



b2v_inst : nec_ir_receiver
PORT MAP(IR_in => IR_IN,
		 clock50MHz => clk,
		 nrst => nrst,
		 ready => o_ready,
		 available => o_available,
		 address => o_address,
		 data => o_data);


b2v_inst6 : nec_ir_transmitter
PORT MAP(clock50MHz => clk,
		 nrst => nrst,
		 available => i_available,
		 Address => i_address,
		 Data => i_data,
		 IR_OUT => IR_OUT,
		 ready => i_ready);


END bdf_type;