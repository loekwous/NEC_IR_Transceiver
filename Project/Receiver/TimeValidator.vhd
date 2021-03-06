library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TimeValidator is

generic(
	maxTime : integer := 1000;
	minTime : integer := 1000
	);

port(
	d_in		: in std_logic_vector(9 downto 0);
	valid		: out std_logic
	);
	
end entity;

architecture behaviour of TimeValidator is
begin
	
	process(d_in)
		variable tempMaxTime : std_logic_vector(9 downto 0);
		variable tempMinTime : std_logic_vector(9 downto 0);
	begin
	
			tempMaxTime := std_logic_vector(to_unsigned(maxTime,10));
			tempMinTime := std_logic_vector(to_unsigned(minTime, 10));
			
			if (d_in > tempMinTime) and (d_in < tempMaxTime) then
				valid <= '1' after 5 ns;
			else
				valid <= '0' after 5 ns;
			end if;
		
	end process;
	
end architecture;