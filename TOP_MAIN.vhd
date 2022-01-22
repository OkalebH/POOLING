library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP_MAIN is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  start : in STD_LOGIC;
           wr : out  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (23 downto 0));
end TOP_MAIN;

architecture Behavioral of TOP_MAIN is
COMPONENT ROM_IMG
	PORT(
		d00 : IN std_logic_vector(6 downto 0);
		d01 : IN std_logic_vector(6 downto 0);
		d10 : IN std_logic_vector(6 downto 0);
		d11 : IN std_logic_vector(6 downto 0);          
		k00 : OUT std_logic_vector(23 downto 0);
		k01 : OUT std_logic_vector(23 downto 0);
		k10 : OUT std_logic_vector(23 downto 0);
		k11 : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;
	COMPONENT get_greater
	PORT(
		d00 : IN std_logic_vector(23 downto 0);
		d01 : IN std_logic_vector(23 downto 0);
		d10 : IN std_logic_vector(23 downto 0);
		d11 : IN std_logic_vector(23 downto 0);          
		dout : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;
COMPONENT op_pooling
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		start : IN std_logic;
		result_in : IN std_logic_vector(23 downto 0);          
		wr : OUT std_logic;
		dout : OUT std_logic_vector(23 downto 0);
		d00 : OUT std_logic_vector(6 downto 0);
		d01 : OUT std_logic_vector(6 downto 0);
		d10 : OUT std_logic_vector(6 downto 0);
		d11 : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

-- SIGNALS --

signal d00x, d01x, d10x, d11x : std_logic_vector(6 downto 0);
signal dk00,dk01,dk10,dk11 : std_logic_vector(23 downto 0);
signal dx : std_logic_vector(23 downto 0);
begin
Activation_Volume: ROM_IMG PORT MAP(
		d00 => d00x,
		d01 => d01x,
		d10 => d10x,
		d11 => d11x,
		k00 => dk00,
		k01 => dk01,
		k10 => dk10,
		k11 => dk11
	);
MAX_POOLING: get_greater PORT MAP(
		d00 => dk00,
		d01 => dk01,
		d10 => dk10,
		d11 => dk11,
		dout => dx
	);
CONTROLLER: op_pooling PORT MAP(
		clk => clk,
		rst => rst,
		start => start,
		result_in => dx,
		wr => wr,
		dout => dout,
		d00 => d00x,
		d01 => d01x,
		d10 => d10x,
		d11 => d11x
	);
end Behavioral;

