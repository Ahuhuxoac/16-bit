
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.Sys_Definition.all;

-- 
entity SoC is
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( rst   : in STD_LOGIC; -- low active reset signal
    	  start : in STD_LOGIC;    -- high active Start: enable cpu
          clk   : in STD_LOGIC    -- Clock
        );
end SoC;


architecture struc of SoC is

-- declare internal signals here
SIGNAL Addr_out : STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
SIGNAL data_out : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
SIGNAL data_in : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
SIGNAL Mre, Mwe : std_logic;
     	  
begin
-- write your code here

--CPU_U;
cpu_unit: CPU
   Generic MAP(
    DATA_WIDTH,     -- Data Width
    ADDR_WIDTH     -- Address width
    )
   port MAP( rst,
    	  start ,
          clk ,
	       Addr_out,
	       data_out ,
	       data_in ,
     	   
     	   -- control signals for accessing to memory
     	   Mre, Mwe
     	    -- add ports as required here
        );

  --Mem_U: dpmem port map (?);
mem_unit: dpmem
  generic map(
    DATA_WIDTH ,  -- Word Width
    ADDR_WIDTH    -- Address width
    )

  port map(
    -- Writing
    Clk   ,
	rst ,
    Addr_out ,
	-- Writing Port
	Mwe ,
    data_in ,
    -- Reading Port
    
    Mre ,
    data_out 
    
    );
							

end struc;