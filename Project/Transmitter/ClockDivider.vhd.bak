library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ClockDivider is

port(
	clk50MHz	: in std_logic;
	sys_clk	: out std_logic
	);
	
end entity;

architecture behaviour of ClockDivider is
	signal counter : integer;
begin
	
	process(clk50MHz)
	begin
	
		if rising_edge(clk50MHz) then
			if (counter = 511) then
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
		end if;
		
	end process;

	process(counter)
		variable counterBits : std_logic_vector(8 downto 0);
	begin
	
		counterBits := std_logic_vector(to_unsigned(counter,9));
		sys_clk <= counterBits(8);
	
	end process;
	
end architecture;