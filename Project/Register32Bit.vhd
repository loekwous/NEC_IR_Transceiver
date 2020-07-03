library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register32Bit is

port(
	Data  	: in std_logic_vector(31 downto 0);
	clk		: in std_logic;
	set		: in std_logic;
	clear		: in std_logic;
	output	: out std_logic_vector(31 downto 0)
	);
	
end entity;

architecture behaviour of Register32Bit is
begin

	process(clk)
	begin
	
		if rising_edge(clk) then
			if clear = '1' then
				output <= (others => '0') after 5 ns;
			elsif set = '1' then
				output <= Data after 5 ns;
			end if;
		end if;
	
	end process;


end architecture;