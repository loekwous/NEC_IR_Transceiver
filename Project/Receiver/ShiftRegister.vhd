library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftRegister is

	port(
		d_in 		: in  std_logic;
		sys_clk 	: in  std_logic;
		clear 	: in  std_logic;
		shift	  	: in std_logic;
		d_out		: out std_logic_vector(31 downto 0)
	);

end entity;

architecture behaviour of ShiftRegister is
	signal reg : std_logic_vector(31 downto 0);
begin

	process(sys_clk)
		variable data : std_logic;
	begin
		
		if rising_edge(sys_clk) then
			if clear = '1' then
				reg <= (others => '0') after 5 ns;			elsif shift = '1' then
				data := d_in;
				reg <= reg(30 downto 0) & data after 5 ns;
			end if;		
		end if;
		
	end process;
	
	d_out <= reg after 5 ns;
	
end architecture;