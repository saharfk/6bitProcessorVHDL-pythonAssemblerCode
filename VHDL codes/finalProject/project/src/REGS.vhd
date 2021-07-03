library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity REGS is	 
	PORT(	RIN : in STD_LOGIC_VECTOR(5 downto 0);
			ROUT0,ROUT1,ROUT2,ROUT3 : out STD_LOGIC_VECTOR(5 downto 0);
			LD0,LD1,LD2,LD3, CLOCK : in std_logic;
			ZR0,ZR1,ZR2,ZR3 : out std_logic);
end REGS;



architecture REGS of REGS is
signal reg0,reg1,reg2,reg3 : std_logic_vector(5 downto 0) := "000000" ;
begin
Process(CLOCK)
	 begin
 		if Rising_edge(CLOCK) then
			if(LD0 = '1')then reg0 <= RIN;
			end if;
		end if;
end process;
Process(CLOCK)
	 begin
 		if Rising_edge(CLOCK) then
			if(LD1 = '1')then reg1 <= RIN;
			end if;
		end if;
end process;
Process(CLOCK)
	 begin
 		if Rising_edge(CLOCK) then
			if(LD2 = '1')then reg2 <= RIN;
			end if;
		end if;
end process;
Process(CLOCK)
	 begin
 		if Rising_edge(CLOCK) then
			if(LD3 = '1')then reg3 <= RIN;
			end if;
		end if;
end process;
ROUT0 <= reg0;
ROUT1 <= reg1;
ROUT2 <= reg2;
ROUT3 <= reg3;
ZR0 <= '1' when reg0 = "000000" else '0' ;
ZR1 <= '1' when reg1 = "000000" else '0' ;
ZR2 <= '1' when reg2 = "000000" else '0' ;
ZR3 <= '1' when reg3 = "000000" else '0' ;
	

end REGS;
