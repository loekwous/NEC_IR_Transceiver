library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataCollector is

port(
	d_in		: in std_logic_vector(31 downto 0);
	address	: out std_logic_vector(15 downto 0);
	data		: out std_logic_vector(7 downto 0);
	valid		: out std_logic
	);
	
end entity;

architecture behaviour of DataCollector is
begin
	
	process(d_in)
		variable tempData, tempIData : std_logic_vector(7 downto 0);
		variable tempAddress : std_logic_vector(15 downto 0);
	begin
	
		tempAddress := d_in(31 downto 16);
		tempData 	:= d_in (15 downto 8);
		tempIData 	:= d_in(7 downto 0);
		
		if tempData = not(tempIData) then
			valid <= '1' after 5 ns;
		else
			valid <= '0' after 5 ns;
		end if;
		
		data 		<= tempData after 5 ns;
		address 	<= tempAddress after 5 ns;
	
	end process;
	
end architecture;