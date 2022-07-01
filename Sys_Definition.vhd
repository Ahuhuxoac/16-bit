-- my lib
library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all ;
use std.textio.all;

package Sys_Definition is

-- Constant for datapath
  Constant   DATA_WIDTH  :     integer   := 16;     -- Word Width
--constant PORT_NUM : integer := 5;

-- Type Definition
   -- type ADDR_ARRAY_TYPE is array (VC_NUM-1 DOWNTO 0) of std_logic_vector (ADDR_WIDTH-1 downto 0);
   

-- **************************************************************
--COMPONENTs
--res file 
component resf is
   Generic (
    DATA_WIDTH : integer   := 16    -- Data Width
    );
   port ( 
	clk,rst : in std_logic;
	rfwa,opr1a,opr2a : in STD_LOGIC_VECTOR (3 downto 0);
	rfwe,opr1e,opr2e : in std_logic;
	rfin : in STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	opr2,opr1 : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
        );
end component;
--alu
component alu is
   Generic (
    DATA_WIDTH : integer   := 16
);
   port (
	clk  : std_logic;
	opr1 : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
     	opr2 : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	aluz : out std_logic;
	alur : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	alus : in STD_LOGIC_VECTOR (1 downto 0)
        );
end component;
-- ir
component ir is
   Generic (
    DATA_WIDTH : integer   := 16    -- Data Width
    );
   port (
     	  clk   : in STD_LOGIC;  
	  ir_in : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	  irld  : in std_logic;
	  ir_out: out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)
        );
end component;
--pc 
component pc is
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
end component;
--mux3to1
component mux31 IS
   GENERIC ( 
	DATA_WIDTH : integer := 16);
   PORT (
	A,B, C: IN  std_logic_vector (DATA_WIDTH-1 downto 0);
        SEL : IN std_logic_vector (1 downto 0);
        Z: OUT std_logic_vector (DATA_WIDTH-1 downto 0)
          );
END component;
-- CPU
COMPONENT cpu
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( rst,clk : in std_logic;
	start : in std_logic;
	data_out : in std_logic_vector(DATA_WIDTH -1 downto 0) ;
	data_in : out std_logic_vector(DATA_WIDTH -1 downto 0);
	address : out std_logic_vector(DATA_WIDTH -1 downto 0);
	mre,mwe : out STD_LOGIC
	 
        );
END COMPONENT;
-- Controller
component controller 
  Generic (
    DATA_WIDTH : integer   := 16
    );
   port (rst   : in STD_LOGIC; -- low active reset signal
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
end component;
-----------------------------
-- Datapath
component datapath is
  Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( -- you will need to add more ports here as design grows
          rst     : in STD_LOGIC;
          clk     : in STD_LOGIC;
	  irout     : in std_logic_vector(15 downto 0);
	  Data_out : in std_logic_vector(DATA_WIDTH - 1 downto 0);
          Data_in : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
	  rfs 	  : in std_logic_vector(1 downto 0);
	  rfwa: in std_logic_vector(3 downto 0);
	  opr1a: in std_logic_vector(3 downto 0);
	  opr2a:in std_logic_vector(3 downto 0);
	  rfwe, opr1e, opr2e : in STD_LOGIC;
	  alus : in std_logic_vector(1 downto 0);
	  aluz : out  std_logic
          -- add ports as required
        );
end component;
--control unit
component control_unit is
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( 
    	start : in STD_LOGIC;    -- high active Start: enable cpu
        clk , rst  : in STD_LOGIC;    -- Clock
	data_out : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	aluz : in STD_LOGIC;
	Addr_out : out STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
	rfwa,opr1a,opr2a : out STD_LOGIC_VECTOR (3 downto 0);
	rfwe,opr1e,opr2e : out STD_LOGIC; 
	ir_out_8 : out STD_LOGIC_VECTOR (15 downto 0);
	rfs : out STD_LOGIC_VECTOR ( 1  downto 0);
	mre,mwe : out std_logic;
	alus : out STD_LOGIC_VECTOR (1 downto 0);
	opr2 : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0)
        );
end component;

-------------------------------------
component dpmem 
   generic (
     DATA_WIDTH        :     integer   := 16;     -- Word Width
     ADDR_WIDTH        :     integer   := 16      -- Address width
     );
 
   port (
     -- Writing
     Clk              : in  std_logic;          -- clock
     rst            : in  std_logic; -- Reset input
     addr              : in  std_logic_vector(ADDR_WIDTH -1 downto 0);   --  Address
     -- Writing Port
     Wen               : in  std_logic;          -- Write Enable
     Datain            : in  std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');   -- Input Data
     -- Reading Port
     
     Ren               : in  std_logic;          -- Read Enable
     Dataout           : out std_logic_vector(DATA_WIDTH -1 downto 0)   -- Output data
     
     );
  
  end component;

--Soc
COMPONENT soc is
   Generic (
    DATA_WIDTH : integer   := 16;     -- Data Width
    ADDR_WIDTH : integer   := 16      -- Address width
    );
   port ( rst   : in STD_LOGIC; -- low active reset signal
    	  start : in STD_LOGIC;    -- high active Start: enable cpu
          clk   : in STD_LOGIC    -- Clock
        );
end COMPONENT;

------------------------------------------------------

-----------------
-- You need to add the other components here......
-----------------
end Sys_Definition;

PACKAGE BODY Sys_Definition IS
	-- package body declarations

END PACKAGE BODY Sys_Definition;