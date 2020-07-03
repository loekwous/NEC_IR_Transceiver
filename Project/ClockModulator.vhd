library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ClockModulator is

port(

	clk50MHz	: in std_logic;
	nrst		: in std_logic;
	data 		: in std_logic;
	modOut 	: out std_logic

);

end entity;


architecture behaviour of ClockModulator is
	signal counter : integer := 0;
	signal modState : std_logic := '0';
begin

	tick : process(clk50MHz, nrst)
	begin
	
		if nrst = '0' then
			counter <= 0;
		elsif rising_edge(clk50MHz) AND (data = '1') then
		
			if counter < 1315 then
				counter <= counter + 1;
			else
				counter <= 0;
			end if;
		
		end if;
	
	end process;
	
	outControl : process(counter)
	begin
	
		if (counter > 658) then
			modState <= '1';
		else
			modState <= '0';
		end if;
	end process;

	modOut <= modState when (data = '1') else '0';
	
end architecture;