library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mod32Counter is

port(
	enable	: in std_logic;
	clear		: in std_logic;
	clk		: in std_logic;
	output	: out std_logic_vector(4 downto 0);
	last		: out std_logic
	);
	
end entity;

architecture behaviour of Mod32Counter is
	signal counter : integer;
begin
	
	process(clk)
	begin
	
		if rising_edge(clk) then
			if clear = '1' or (counter = 31) then
				counter <= 0;
			elsif enable = '1' then
				counter <= counter + 1;
			end if;
		end if;
	end process;
	
	process(counter)
	begin
	
		if (counter = 31) then
			last <= '1';
		else
			last <= '0';
		end if;
	
	end process;

	output <= std_logic_vector(to_unsigned(counter,5));
	
end architecture;