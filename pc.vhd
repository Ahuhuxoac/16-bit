
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use work.sys_definition.all;

-- 
entity pc is
   Generic (
    DATA_WIDTH : integer   := 16     -- Data Width
    );
   port (
     	  clk   : in STD_LOGIC;  
	  pc_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	  pcclr : in std_logic;
	  pcinc : in std_logic;
	  pcld  : in std_logic;
	  pc_out: out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)
        );
end pc;


 architecture struc of pc is
 signal pc: STD_LOGIC_VECTOR(15 downto 0);
 begin
	process (clk)
	begin
		IF (PCclr = '1') THEN PC <= (OTHERS => '0');
		elsif clk'event and clk = '1' then
			if (pcld = '1') then 
				pc <= pc_in;
			elsif (pcinc = '1') then
				pc <= STD_LOGIC_VECTOR(unsigned(pc) + 1);
			else
				pc <= x"0000" ;
			end if;
		end if;
	end process;
pc_out <= pc;

							

end struc;
