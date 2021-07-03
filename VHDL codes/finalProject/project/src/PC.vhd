library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity PC is  
	PORT( RIN : in std_logic_vector(5 downto 0);
		  ROUT : out std_Logic_vector( 5 downto 0);
		  CLOCK, LD, INC, CLR : in std_logic);
end PC;



architecture PC of PC is
signal regs : std_logic_vector( 5 downto 0);
begin
	Process( CLOCK, CLR)
	variable reg : std_logic_vector( 5 downto 0) := "000000";
	begin
		if( CLR = '1') then reg := "000000";
		elsif( Rising_edge(CLOCK)) then
			if( LD = '1') then reg := RIN;
			end if;
			if ( INC = '1') then reg := reg + 1;
			end if;
		end if;
		regs <= reg;
	end process;
ROUT <= regs;
end PC;
