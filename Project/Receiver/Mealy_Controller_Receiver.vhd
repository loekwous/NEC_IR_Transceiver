library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mealy_Controller_Receiver is

	port(
		IR_in 		: in  std_logic;
		last 			: in  std_logic;
		short 		: in  std_logic;
		long 			: in  std_logic;
		b_short 		: in  std_logic;
		b_long 		: in  std_logic;
		valid			: in  std_logic;
		sys_clk 		: in  std_logic;
		nrst 			: in  std_logic;
		ready		 	: in  std_logic;
		
		clear 		: out std_logic;
		shift		 	: out std_logic;
		D_shift 		: out std_logic;
		t_clear 		: out std_logic;
		cnt	 		: out std_logic;
		available	: out std_logic
	);

end entity;

architecture behaviour of Mealy_Controller_Receiver is
	type state is (Sx, S0, S1, S2, S3, S4, S5, S6);
	signal present_state, next_state : state;
begin

-- Input decoder
input_dec : process(present_state, IR_in, last, short, long, b_short, b_long, ready, valid)
	variable n_s : state;
begin
	case present_state is
		when S0 => 
			if IR_in = '1' then
				n_s := S1;
			else
				n_s := S0;
			end if;
		when S1 =>
			if IR_in = '0' then
				if b_long = '1' then
					n_s := S2;
				else
					n_s := S0;
				end if;
			else
				n_s := S1;
			end if;
		when S2 =>
			if IR_in = '1' then
				if b_short = '1' then
					n_s := S3;
				else
					n_s := S0;
				end if;
			else
				n_s := S2;
			end if;
		when S3 =>
			if IR_in = '0' then
				if short = '1' then
					n_s := S4;
				else
					n_s := S0;
				end if;
			else
				n_s := S3;
			end if;
		when S4 =>
			if IR_in = '1'then
				if last = '1' then
					n_s := S5;
				else
					if short = '1' then
						n_s := S3;
					else
						if long = '1' then
							n_s := S3;
						else
							n_s := S0;
						end if;
					end if;
				end if;
			else
				n_s := S4;
			end if;
		when S5 =>
			if IR_in = '0' then
				if short = '1' then
					if valid = '1' then
						n_s := S6;
					else
						n_s := S0;
					end if;
				else
					n_s := S0;
				end if;
			else
				n_s := S5;
			end if;
		when S6 =>
			if ready = '1' then
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
output_dec : process(present_state, IR_in, last, short, long, b_short, b_long, ready, valid)
begin

	case present_state is
		when S0 => -- Clear all devices
			clear 		<= '1' after 5 ns;
			shift			<= '0' after 5 ns;
			D_shift 		<= '0' after 5 ns;
			t_clear 		<= '1' after 5 ns;
			cnt	 		<= '0' after 5 ns;
			available	<= '0' after 5 ns;
		when S1 => 
			if (IR_in = '0') and (b_long = '1') then -- Clear timer when IR is low and burst long is valid
				clear 		<= '0' after 5 ns;
				shift			<= '0' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '1' after 5 ns;
				cnt	 		<= '0' after 5 ns;
				available	<= '0' after 5 ns;
			else
				clear 		<= '0' after 5 ns;
				shift			<= '0' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '0' after 5 ns;
				cnt	 		<= '0' after 5 ns;
				available	<= '0' after 5 ns;
			end if;
		when S2 => 
			if (IR_in = '1') and (b_short = '1') then -- Clear timer when IR is high and burst short is valid
				clear 		<= '0' after 5 ns;
				shift			<= '0' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '1' after 5 ns;
				cnt	 		<= '0' after 5 ns;
				available	<= '0' after 5 ns;
			else
				clear 		<= '0' after 5 ns;
				shift			<= '0' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '0' after 5 ns;
				cnt	 		<= '0' after 5 ns;
				available	<= '0' after 5 ns;
			end if;
		when S3 =>
			if (IR_in = '0') and (short = '1') then
				clear 		<= '0' after 5 ns;
				shift			<= '0' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '1' after 5 ns;
				cnt	 		<= '0' after 5 ns;
				available	<= '0' after 5 ns;
			else
				clear 		<= '0' after 5 ns;
				shift			<= '0' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '0' after 5 ns;
				cnt	 		<= '0' after 5 ns;
				available	<= '0' after 5 ns;
			end if;
		when S4 => -- Shift data while not last character
			if (IR_in = '1') and (last = '1') then 
				clear 		<= '0' after 5 ns;
				shift			<= '0' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '1' after 5 ns;
				cnt	 		<= '0' after 5 ns;
				available	<= '0' after 5 ns;
			elsif (IR_in = '1') and (last = '0') and (short = '1') then 
				clear 		<= '0' after 5 ns;
				shift			<= '1' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '1' after 5 ns;
				cnt	 		<= '1' after 5 ns;
				available	<= '0' after 5 ns;
			elsif (IR_in = '1') and (last = '0') and (short = '0') and (long = '1') then 
				clear 		<= '0' after 5 ns;
				shift			<= '1' after 5 ns;
				D_shift 		<= '1' after 5 ns;
				t_clear 		<= '1' after 5 ns;
				cnt	 		<= '1' after 5 ns;
				available	<= '0' after 5 ns;
			else
				clear 		<= '0' after 5 ns;
				shift			<= '0' after 5 ns;
				D_shift 		<= '0' after 5 ns;
				t_clear 		<= '0' after 5 ns;
				cnt	 		<= '0' after 5 ns;
				available	<= '0' after 5 ns;
			end if;
		when S5 =>
			clear 		<= '0' after 5 ns;
			shift			<= '0' after 5 ns;
			D_shift 		<= '0' after 5 ns;
			t_clear 		<= '0' after 5 ns;
			cnt	 		<= '0' after 5 ns;
			available	<= '0' after 5 ns;
		when S6 =>
			clear 		<= '0' after 5 ns;
			shift			<= '0' after 5 ns;
			D_shift 		<= '0' after 5 ns;
			t_clear 		<= '0' after 5 ns;
			cnt	 		<= '0' after 5 ns;
			available	<= '1' after 5 ns;
		when others =>
			clear 		<= 'X' after 5 ns;
			shift			<= 'X' after 5 ns;
			D_shift 		<= 'X' after 5 ns;
			t_clear 		<= 'X' after 5 ns;
			cnt	 		<= 'X' after 5 ns;
			available	<= 'X' after 5 ns;
	end case;

end process;

end architecture;