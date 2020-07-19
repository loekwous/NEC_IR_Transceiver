library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity recMod32Counter is

	port(
		clear : in std_logic;
		sys_clk : in std_logic;
		cnt : in std_logic;
		last : out std_logic
	);

end entity;

architecture behaviour of recMod32Counter is
	signal counter : integer;
begin

	process(sys_clk)
	begin
	
		if rising_edge(sys_clk) then
			if clear = '1' then
				counter <= 0 after 5 ns;
			elsif cnt = '1' then
				if counter < 31 then
					counter <= counter + 1 after 5 ns;
				else
					counter <= 0 after 5 ns;
				end if;
			end if;
		end if;
	
	end process;

	process(counter)
	begin
	
		if counter = 31 then
			last <= '1' after 5 ns;
		else
			last <= '0' after 5 ns;
		end if;
	
	end process;
	
end architecture;