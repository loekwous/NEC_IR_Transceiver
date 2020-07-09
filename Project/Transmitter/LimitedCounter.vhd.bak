library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LimitedCounter is

port(
		clear 	: in std_logic;
		clk		: in std_logic;
		short		: out std_logic;
		long		: out std_logic;
		b_short 	: out std_logic;
		b_long	: out std_logic
	);
	
end entity;

architecture behaviour of LimitedCounter is
	signal counter : integer;
begin
	
	process(clk)
	begin
	
		if rising_edge(clk) then
	
			if clear = '1' then
				counter <= 0;
			else
				counter <= counter + 1;
			end if;
	
		end if;
	
	end process;
	
	process(counter)
	begin
	
		if counter > 109 then
			short <= '1';
		else
			short <= '0';
		end if;
		
		if counter > 329 then
			long <= '1';
		else
			long <= '0';
		end if;
		
		if counter > 878 then
			b_short <= '1';
		else
			b_short <= '0';
		end if;
		
		if counter > 1757 then
			b_long <= '1';
		else
			b_long <= '0';
		end if;
	
	end process;

end architecture;