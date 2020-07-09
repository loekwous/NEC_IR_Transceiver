library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataFormatter is

port(
	Address  : in std_logic_vector(15 downto 0);
	Data		: in std_logic_vector(7 downto 0);
	output	: out std_logic_vector(31 downto 0)
	);
	
end entity;

architecture behaviour of DataFormatter is
begin

	output <= Address & Data & not(Data) after 5 ns;


end architecture;