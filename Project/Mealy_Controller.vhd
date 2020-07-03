library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mealy_Controller is

	port(
		d_bit 		: in  std_logic;
		last 			: in  std_logic;
		short 		: in  std_logic;
		long 			: in  std_logic;
		b_short 		: in  std_logic;
		b_long 		: in  std_logic;
		sys_clk 		: in  std_logic;
		nrst 			: in  std_logic;
		available 	: in  std_logic;
		
		clear 		: out std_logic;
		s_enable 	: out std_logic;
		r_set 		: out std_logic;
		t_clear 		: out std_logic;
		c_out 		: out std_logic;
		ready 		: out std_logic
	);

end entity;

architecture behaviour of Mealy_Controller is
	type state is (Sx, S0, S1, S2, S3, S4, S5, S6);
	signal present_state, next_state : state;
begin

-- Input decoder
input_dec : process(present_state, d_bit, last, short, long, b_short, b_long, available)
	variable n_s : state;
begin
	case present_state is
		when S0 => 
			if available = '1' then
				n_s := S1;
			else
				n_s := S0;
			end if;
		when S1 =>
			if b_long = '1' then
				n_s := S2;
			else
				n_s := S1;
			end if;
		when S2 =>
			if b_short = '1' then
				n_s := S3;
			else
				n_s := S2;
			end if;
		when S3 =>
			if short = '1' then
				if d_bit = '1' then
					n_s := S4;
				else
					n_s := S5;
				end if;
			else
				n_s := S3;
			end if;
		when S4 =>
			if long = '1'then
				if last = '1' then
					n_s := S6;
				else
					n_s := S3;
				end if;
			else
				n_s := S4;
			end if;
		when S5 =>
			if short = '1' then
				if last = '1' then
					n_s := S6;
				else
					n_s := S3;
				end if;
			else
				n_s := S5;
			end if;
		when S6 =>
			if short = '1' then
				n_s := S0;
			else
				n_s := S6;
			end if;
		when others => n_s := Sx;
	end case;
	
	next_state <= n_s after 5 ns;
	
end process;

-- Memory
mem : process(sys_clk, nrst)
begin
	if nrst = '0' then
		present_state <= S0 after 5 ns;
	elsif rising_edge(sys_clk) then
		present_state <= next_state after 5 ns;
	end if;

end process;

-- Output decoder
output_dec : process(present_state, d_bit, last, short, long, b_short, b_long, available)
begin

	case present_state is
		when S0 => -- Clear timer and set ready until available, then set register 
			if available = '1' then
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '1' after 5 ns;
				t_clear 	<= '1' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '0' after 5 ns;
			else
				clear 	<= '1' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '1' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '1' after 5 ns;
			end if;
		when S1 => -- Enable c_out until timer is finished then clear timer
			if b_long = '1' then
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '1' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '0' after 5 ns;
			else
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '0' after 5 ns;
				c_out 	<= '1' after 5 ns;
				ready 	<= '0' after 5 ns;
			end if;
		when S2 => -- Do nothing until timer is finished then clear timer
			if b_short = '1' then
				clear 	<= '0' after 5 ns;
				s_enable <= '1' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '1' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '0' after 5 ns;
			else
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '0' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '0' after 5 ns;
			end if;
		when S3 => -- Enable c_out until timer is finished then clear timer
			if short = '1' then
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '0' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '0' after 5 ns;
			else
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '0' after 5 ns;
				c_out 	<= '1' after 5 ns;
				ready 	<= '0' after 5 ns;
			end if;
		when S4 => -- Do nothing until timer is finished then clear timer or also enable s
			if long = '1' then 
				if last = '1' then
					clear 	<= '0' after 5 ns;
					s_enable <= '0' after 5 ns;
					r_set 	<= '0' after 5 ns;
					t_clear 	<= '1' after 5 ns;
					c_out 	<= '0' after 5 ns;
					ready 	<= '0' after 5 ns;
				else
					clear 	<= '0' after 5 ns;
					s_enable <= '1' after 5 ns;
					r_set 	<= '0' after 5 ns;
					t_clear 	<= '1' after 5 ns;
					c_out 	<= '0' after 5 ns;
					ready 	<= '0' after 5 ns;
				end if;
			else
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '0' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '0' after 5 ns;
			end if;
		when S5 => -- Almost same as S4
			if short = '1' then
				if last = '1' then
					clear 	<= '0' after 5 ns;
					s_enable <= '0' after 5 ns;
					r_set 	<= '0' after 5 ns;
					t_clear 	<= '1' after 5 ns;
					c_out 	<= '0' after 5 ns;
					ready 	<= '0' after 5 ns;
				else
					clear 	<= '0' after 5 ns;
					s_enable <= '1' after 5 ns;
					r_set 	<= '0' after 5 ns;
					t_clear 	<= '1' after 5 ns;
					c_out 	<= '0' after 5 ns;
					ready 	<= '0' after 5 ns;
				end if;
			else
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '0' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '0' after 5 ns;
			end if;
		when S6 => -- Enable output until timer is finished then output ready
			if short = '1' then
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '0' after 5 ns;
				c_out 	<= '0' after 5 ns;
				ready 	<= '1' after 5 ns;
			else
				clear 	<= '0' after 5 ns;
				s_enable <= '0' after 5 ns;
				r_set 	<= '0' after 5 ns;
				t_clear 	<= '0' after 5 ns;
				c_out 	<= '1' after 5 ns;
				ready 	<= '0' after 5 ns;
			end if;
		when others =>
			clear 	<= 'X' after 5 ns;
			s_enable <= 'X' after 5 ns;
			r_set 	<= 'X' after 5 ns;
			t_clear 	<= 'X' after 5 ns;
			c_out 	<= 'X' after 5 ns;
			ready 	<= 'X' after 5 ns;
	end case;

end process;

end architecture;