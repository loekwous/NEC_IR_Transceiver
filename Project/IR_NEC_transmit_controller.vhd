library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR_NEC_transmit_controller is

port(
	clk,nrst		: in std_logic;
	s_last 		: in std_logic;
	available 	: in std_logic;
	short 		: in std_logic;
	long 			: in std_logic;
	b_short 		: in std_logic;
	b_long 		: in std_logic;
	d_bit 		: in std_logic;
	
	r_set 		: out std_logic;
	r_clear 		: out std_logic;
	ready 		: out std_logic;
	t_clear 		: out std_logic;
	c_out 		: out std_logic;
	s_clear 		: out std_logic;
	s_clear 		: out std_logic
	);
	
end entity;

architecture behaviour of IR_NEC_transmit_controller is
	type states is (IDLE, INITON, INITOFF, HIGHPULSE, ONELOW, ZEROLOW,LASTPULSE);
	signal presentState, nextState : states;
begin
	
	inputdecoder : process(presentState, s_last, available, short, long, b_short, b_long, d_bit)
	begin
		case presentState is
			when IDLE =>
				if available = '1' then
					nextState <= INITON;
				else
					nextState <= IDLE;
				end if;
			when INITON =>
				if b_long = '1' then
					nextState <= INITOFF;
				else
					nextState <= INITON;
				end if;
			when INITOFF =>
				if b_short = '1' then
					nextState <= HIGHPULSE;
				else
					nextState <= INITOFF;
				end if;
			when HIGHPULSE =>
				if short = '1' then
					if d_bit = '1' then
						nextState <= ONELOW;
					else
						nextState <= ZEROLOW;
					end if;
				else
					nextState <= HIGHPULSE;
				end if;
			when ONELOW =>
				if long = '1' then
					if last = '1' then
						nextState <= LASTPULSE;
					else
						nextState <= HIGHPULSE;
					end if;
				else
					nextState <= ONELOW;
				end if;
			when ZEROLOW =>
				if short = '1' then
					if last = '1' then
						nextState <= LASTPULSE;
					else
						nextState <= HIGHPULSE;
					end if;
				else
					nextState <= ONELOW;
				end if;
			when LASTPULSE =>
				if short = '1' then
					nextState <= IDLE;
				else
					nextState <= LASTPULSE;
				end if;
			when others =>
				nextState <= IDLE;
			end case;
	end process;
	
	memory : process(clk, nrst)
	begin
		if nrst = '0' then
			presentState <= IDLE;
		elsif rising_edge(clk) then
			presentState <= nextState;
		end if;
	end process;
	
	outputDecoder: process()
	begin
	
	end process;
	
end architecture;