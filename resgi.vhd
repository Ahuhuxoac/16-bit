library IEEE;
use IEEE.std_logic_1164.all;
use work.sys_definition.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity resf is
   Generic (
    DATA_WIDTH : integer  := 16
    );
   port ( 
	clk,rst : in std_logic;
	rfwa,opr1a,opr2a : in STD_LOGIC_VECTOR (3 downto 0);
	rfwe,opr1e,opr2e : in std_logic;
	rfin : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	opr2,opr1 : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
        );
end resf;
 

architecture struc of resf is
	type reg_array is array(integer range<>) of STD_LOGIC_VECTOR (15 downto 0);
    	signal reg_file: reg_array(0 to 15) := (others => (others => '0'));
begin
process (clk,rst)
begin
	if (rst = '1') then 
		OPr1 <= x"0000"; 
		OPr2 <= x"0000"; 
		reg_file <= (others =>(others =>'0'));
		reg_file(9) <= x"0002";
	elsif (clk'event and clk = '1') then
		if OPr1e = '1' then            
			opr1 <= reg_file(to_integer(unsigned(opr1a)));
		end if;
		if OPr2e = '1' then
            		opr2 <= reg_file(to_integer(unsigned(opr2a)));
		end if;
            
            	if rfwe ='1' then
                	reg_file(to_integer(unsigned(rfwa))) <= rfin;
            	end if;
        end if;
end process;
end struc; 
