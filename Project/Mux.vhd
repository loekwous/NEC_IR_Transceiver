library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux is

port(
	Data		: in std_logic_vector(31 downto 0);
	sel		: in std_logic_vector(4 downto 0);
	output	: out std_logic
	);
	
end entity;

architecture behaviour of Mux is
begin
	
	process(sel,Data)
		variable currentBit : integer;
	begin
	
		currentBit := to_integer(unsigned(sel));
		output <= data(currentBit) after 5 ns;

	end process;

end architecture;