library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpu_with_control is
	PORT(  CLOCK , RST: in std_logic ;
	   mem_content,out0, out1, out2, out3: out std_logic_vector(5 downto 0)) ;
end cpu_with_control;



architecture cpu_with_control of cpu_with_control is
signal LD0, LD1, LD2, LD3, LDPC, LDIR, sel0, sel1, sel2, sel3, Bus_sel, CMD, INC, CLR, ZR0, ZR1, ZR2, ZR3: std_logic := '0';
Signal index : integer;
Signal  addr, IR, Bus6, MData, Rout0, rout1, ROut2, Rout3, IN1, IN2, ALURes : std_logic_vector(5 downto 0):="000000";
TYPE States is (S0, S1,decision, S2, S3, S4, S5, S6, S7);
Signal PresentState: States;
Signal Z : std_logic_vector(3 downto 0);
begin
index <= to_integer(unsigned(IR(3 downto 2)));
Z(0) <= ZR0;Z(1) <= ZR1;Z(2) <= ZR2;Z(3) <= ZR3;
	process(CLOCK, RST)
	begin
	   if( RST = '1') then
			PresentState <= S0;
			CLR <= '1';
			Bus_Sel <= '0';
			LDIR <='0';
			INC <= '0';
			LD0 <= '0';LD1 <= '0';LD2 <= '0';LD3 <= '0';
		elsif(Rising_edge(CLOCK))then 
			Case PresentState is 
			When S0 =>
				INC <= '1';
				PresentState <= S1;
			    LDIR <= '1';		
		      	Bus_Sel <= '0';
		      	LDPC <='0';
		     	LD0 <= '0';LD1 <= '0';LD2 <= '0';LD3 <= '0';  
			When S1 =>
				CLR <= '0';
				PresentState <= decision;
				INC <= '0';	
	   			LDIR <= '0';   	
			when decision => 
				if( IR = "111111")then PresentState <= S2;
				else
					if(IR(5 downto 4) = "00")then PresentState <= S3;
					elsif(IR(5 downto 4) = "01")then PresentState <= S4;
					elsif(IR(5 downto 4) = "10")then PresentState <= S5;
					else
						if(Z(index) = '0')then PresentState <= S6;
						else PresentState <= S7;
						end if;
					end if;
				end if;	  
			when S2 =>
				PresentState <= S2;	
			when S3 =>
				if(IR(3 downto 2) = "00")then LD0 <= '1';
				elsif(IR(3 downto 2) = "01")then LD1 <= '1';
				elsif(IR(3 downto 2) = "10")then LD2 <= '1';
				else LD3 <= '1';
				end if;
				INC <= '1';PresentState <= S0;
			when S4 =>
				sel1 <= IR(3);sel0 <= IR(2);sel3 <= IR(1);sel2 <= IR(0);
				if(IR(3 downto 2) = "00")then LD0 <= '1';
				elsif(IR(3 downto 2) = "01")then LD1 <= '1';
				elsif(IR(3 downto 2) = "10")then LD2 <= '1';
				elsif(IR(3 downto 2) = "11")then LD3 <= '1';
				end if;
				CMD <= '1';
				Bus_Sel <= '1';
				PresentState <= S0;	  
			when S5 =>
				sel1 <= IR(3);sel0 <= IR(2);sel3 <= IR(1);sel2 <= IR(0);
				if(IR(3 downto 2) = "00")then LD0 <= '1';
				elsif(IR(3 downto 2) = "01")then LD1 <= '1';
				elsif(IR(3 downto 2) = "10")then LD2 <= '1';
				elsif(IR(3 downto 2) = "11")then LD3 <= '1';
				end if;
				CMD <= '0';
				Bus_Sel <= '1';
				PresentState <= S0;	
			when S6 =>
				LDPC <= '1';
				PresentState <= S0;
			when S7 =>
				INC <= '1';
				PresentState <= S0;
			end case;
		end if;
	end process;
Memory : Entity work.Memory(Memory)	port map( Addr => Addr,CLOCK => CLOCK,Dout => MData);				 
PC : Entity work.PC(PC) port map( RIN => Bus6,ROUT => Addr,CLOCK => CLOCK,LD => LDPC,INC => INC,CLR => RST);					
IR_inst : Entity work.IR(IR) port map( RIN => Bus6,Rout => IR,LD => LDIR,CLOCK => CLOCK);	
ALU : Entity work.ALU(ALU)port map( IN1 => IN1,IN2 => IN2,CMD => CMD,Result => ALURes);
Regs : Entity work.Regs(Regs) port map( RIN => Bus6,ROUT0 => Rout0,ROUT1 => Rout1,ROUT2 => Rout2,ROUT3 => Rout3,
	ZR0 => ZR0,ZR1 => ZR1,ZR2 => ZR2,ZR3 => ZR3,LD0 => LD0,LD1 => LD1,LD2 => LD2,LD3 => LD3,CLOCK => CLOCK); 
out0<= Rout0;
out1<= Rout1;
out2<= Rout2;
out3<= Rout3;		
mem_content <= MData;	
Bus_selion : process( Bus_Sel,ALUres, MData )
begin
	if(Bus_Sel = '1')then Bus6 <= ALUres;
	else Bus6 <= MData;
	end if;
end process;
Mux1 : process( sel1,sel0,Rout0,Rout1,Rout2,Rout3 )
begin
	if(sel1 = '0' and sel0 = '0')then IN1 <= Rout0;
	elsif(sel1 = '0' and sel0 = '1')then IN1 <= Rout1;
	elsif(sel1 = '1' and sel0 = '0')then IN1 <= Rout2;
	else IN1 <= Rout3;
	end if;
end process;
Mux2 : process( sel2,sel3,Rout0,Rout1,Rout2,Rout3 )
begin
	if(sel3 = '0' and sel2 = '0')then IN2 <= Rout0;
	elsif(sel3 = '0' and sel2 = '1')then IN2 <= Rout1;
	elsif(sel3 = '1' and sel2 = '0')then IN2 <= Rout2;
	else IN2 <= Rout3;
	end if;
end process;

	

end cpu_with_control;
