-- Nguyen Kiem Hung
-- datapath for microprocessor

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.sys_definition.all;

entity datapath is
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
end datapath;

architecture struct of datapath is
signal rfin, alur,opr1,opr2 : std_logic_vector(Data_width - 1 downto 0);
begin
-- mux 31
	mux3to1 : mux31
GENERIC map ( 
	DATA_WIDTH)
PORT map 
	(
	alur,irout,data_out,
	rfs,
	rfin
          );

-- res file 16
	rf16: resf
		generic map(DAta_width)
		port map (
			clk,rst,
			rfwa,opr1a,opr2a ,
			rfwe,opr1e,opr2e ,
			rfin ,
			opr2,opr1 		
		);
-- alu
	alu1: alu
		Generic map (DATA_WIDTH)
   		port map  (
			clk,
			opr1,
     			opr2,
			aluz,
			alur,
			alus
        );
	
end struct;


