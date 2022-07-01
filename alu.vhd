
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use work.sys_definition.all;

entity alu is
   Generic (
    DATA_WIDTH : integer   := 16     -- Data Width
    );
   port (
	clk  : std_logic;
	opr1 : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
     	opr2 : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	aluz : out std_logic;
	alur : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	alus : in STD_LOGIC_VECTOR (1 downto 0)
        );
end alu;


architecture struc of alu is
signal result : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
begin
process(alus,opr1,opr2)
begin
	case alus is
		when "00" =>
			result <= STD_LOGIC_VECTOR(signed(opr1) + signed(opr2));
		when "01" =>
			result <= STD_LOGIC_VECTOR(signed(opr1) - signed(opr2));
		when "10" =>
			result <= STD_LOGIC_VECTOR(signed(opr1) or signed(opr2));
		when others =>
			result <= STD_LOGIC_VECTOR(signed(opr1) and signed(opr2));
		
	end case;
end process;
alur <= result;
aluz <= '1' when opr1 = x"0000" else '0';
end struc;