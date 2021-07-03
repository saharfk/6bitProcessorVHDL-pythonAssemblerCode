library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity IR is   
	PORT(	RIN : in STD_LOGIC_VECTOR(5 downto 0);
			ROUT : out STD_LOGIC_VECTOR(5 downto 0);
			LD, CLOCK : in std_logic);
end IR;



architecture IR of IR is
signal reg : std_logic_vector(5 downto 0);
begin
	Process(CLOCK)
	 begin
 		if Rising_edge(CLOCK) then
			if(LD = '1')then reg <= RIN;
			end if;
		end if;
	end process;
ROUT <= reg;

end IR;
