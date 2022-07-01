-- Nguyen Kiem Hung
-- controller

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

entity controller is             	
  Generic (
    DATA_WIDTH : integer   := 16   -- Data Width
    );
   port (-- you will need to add more ports here as design grows
         rst   : in STD_LOGIC; -- low active reset signal
    	 start : in STD_LOGIC;    -- high active Start: enable cpu
         clk   : in STD_LOGIC;    -- Clock
	 IR_out : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
     	 ALUz  : in std_logic; 
	 alus,ms :  out STD_LOGIC_VECTOR (1 downto 0);
     	 RFs    : out std_logic_vector(1 downto 0);
     	 Mre, Mwe : out std_logic;
     	 opr1a,opr2a,rfwa: out STD_LOGIC_VECTOR (3 downto 0);
	 opr1e,opr2e,rfwe: out STD_LOGIC;
         pcclr,pcinc,pcld,irld : out std_logic
        );                              
 
end controller;

architecture fsm of controller is
type state_type is (reset, fetch, ldIR, incPC, decode, mov1, mov11, mov2, mov21, mov3, mov31, 
mov4, add, add1, sub, sub1, jpz, jpz1, ors, or1, ands, and1, jmp, jmp1);
signal state : state_type;
signal op, rm, rn : std_logic_vector (3 downto 0);
begin 
rn <= IR_out(11 DOWNTO 8);
rm <= IR_out(7 DOWNTO 4);
op <= IR_out(15 DOWNTO 12);
fsm : process(rst,clk)
begin
if (rst = '1' ) then
	state <= reset;
elsif (clk 'event and clk = '1') then
	CASE state is
		when reset =>
			IF(start = '1') then state <= fetch; end if;
		when fetch =>
			state <= ldIR;
		when ldIR =>
			state <= incPC;
		when incPC =>
			state <= decode;
		when decode =>
		CASE Op IS
			WHEN "0000" => state <= mov1;
			WHEN "0001" => state <= mov2;
			WHEN "0010" => state <= mov3;
			WHEN "0011" => state <= mov4;
			WHEN "0100" => 	state <= add;
			WHEN "0101" => state <= sub;
			WHEN "0110" => state <= jpz;
			WHEN "0111" => state <= ors;
			WHEN "1000" => state <= ands;
			WHEN "1001" => state <= jmp;
			WHEN OTHERS => state <= fetch;
		END CASE;
		WHEN mov1 => state <= mov11;
		WHEN mov11 => state <= fetch;
		WHEN mov2 => state <= mov21;
		WHEN mov21 => state <= fetch;
		WHEN mov3 => state <= mov31;
		WHEN mov31 => state <= fetch;
		WHEN mov4 => state <= fetch;
		WHEN add => state <= add1;
		WHEN add1 => state <= fetch;
		WHEN sub => state <= sub1;
		WHEN sub1 => state <= fetch;
		WHEN  jpz => state <= jpz1;
		WHEN jpz1 => state <= fetch;
		WHEN ors => state <= or1;
		WHEN or1 => state <= fetch;
		WHEN ands => state <= and1;
		WHEN and1 => state <= fetch;
		WHEN jmp => state <= jmp1;
		WHEN jmp1 => state <= fetch;
		WHEN OTHERS => state <= fetch;
	end case;
end if;
end process;				
			
-- logic combinational
PCclr <= '1' WHEN state = reset else '0';
PCinc <= '1' WHEN state = incPC else '0';
WITH state SELECT
	PCld <= ALUz WHEN jpz1,
		'1' WHEN jmp,
		'0' WHEN OTHERS;
--ir
IRld <= '1' WHEN state = ldIR else '0';
--address
WITH state SELECT
	Ms <=   "01" WHEN mov1|mov21,
		"00" WHEN mov31,
		"10" WHEN fetch,
		"11" WHEN OTHERS;
Mre <= '1' WHEN (state = fetch or state = mov1) ELSE '0';
Mwe <= '1' WHEN (state = mov21 or state = mov31) ELSE '0';
--RF
WITH state SELECT 
	RFs <=  "01" WHEN mov4,
		"00" WHEN add1|sub1|and1|or1,
		"10" WHEN mov11,
		"11" WHEN OTHERS;
WITH state SELECT
	RFwa <= rn WHEN mov11|mov4|add1|sub1|and1|or1,
		"0000" WHEN OTHERS;
WITH state SELECT
	RFwe <= '1' WHEN mov11|mov4|add1|sub1|and1|or1,
		'0' WHEN OTHERS;
WITH state SELECT
	OPR1a <= rn WHEN mov2|add|mov3|sub|jpz|ors|ands|jmp,
		"0000" WHEN OTHERS;
WITH state SELECT
	OPR1e <= '1' WHEN mov2|mov3|add|sub|jpz|ors|ands|jmp,
		'0' WHEN OTHERS;
WITH state SELECT
	OPR2a <= rm WHEN mov3|add|sub|ors|ands,
		"0000" WHEN OTHERS;
WITH state SELECT
	OPR2e <= '1' WHEN mov3|add|sub|ors|ands,
	'0' WHEN OTHERS;
WITH state SELECT
	ALUs <= "01" WHEN sub|sub1,
		"00" WHEN add|add1,
		"10" WHEN ors|or1,
		"11" WHEN OTHERS;
					
end fsm;









