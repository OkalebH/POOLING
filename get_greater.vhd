library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity get_greater is
    Port ( d00 : in  STD_LOGIC_VECTOR (23 downto 0);
           d01 : in  STD_LOGIC_VECTOR (23 downto 0);
           d10 : in  STD_LOGIC_VECTOR (23 downto 0);
           d11 : in  STD_LOGIC_VECTOR (23 downto 0);
           dout : out  STD_LOGIC_VECTOR (23 downto 0));
end get_greater;

architecture Behavioral of get_greater is
	signal g1,g2 : std_logic_vector(23 downto 0);
begin

process(d00,d01,d10,d11)
begin
	if(d00(22 downto 0) > d01(22 downto 0)) then
		g1 <= d00;
	else
		g1 <= d01;
	end if;
	
	if(d10(22 downto 0) > d11(22 downto 0)) then
		g2 <= d10;
	else
		g2 <= d11;
	end if;
	
	if(g1(22 downto 0) > g2(22 downto 0)) then
		dout <= g1;
	else
		dout <= g2;
	end if;
end process;

end Behavioral;

