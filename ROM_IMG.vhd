library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM_IMG is
	port(
			d00 : in std_logic_vector (6 downto 0);
			d01 : in std_logic_vector (6 downto 0);
			d10 : in std_logic_vector(6 downto 0);
			d11 : in std_logic_vector(6 downto 0);
			k00 : out std_logic_vector(23 downto 0);
			k01 : out std_logic_vector(23 downto 0);
			k10 : out std_logic_vector(23 downto 0);
			k11 : out std_logic_vector(23 downto 0));
end ROM_IMG;

architecture Behavioral of ROM_IMG is
	type ROM is array(natural range <>) of std_logic_vector(23 downto 0);
	constant img : ROM(0 to 99) := (	x"3f8000",
												x"3efefe",
												x"3f8000",
												x"3efefe",
												x"3f8000",
												x"000000",
												x"000000",
												x"000000",
												x"000000",
												x"000000",
												x"3f8000",
												x"000000",
												x"3f8000",
												x"3efefe",
												x"3f8000",
												x"000000",
												x"3f43c3",
												x"000000",
												x"000000",
												x"000000",
												x"3f8000",
												x"3efefe",
												x"000000",
												x"3f8000",
												x"3f8000",
												x"000000",
												x"3f8000",
												x"3f43c3",
												x"000000",
												x"000000",
												x"3f8000",
												x"3efefe",
												x"3efefe",
												x"000000",
												x"3f8000",
												x"000000",
												x"3f8000",
												x"3f8000",
												x"3f43c3",
												x"3f8000",
												x"3f8000",
												x"3f8000",
												x"3f8000",
												x"3f8000",
												x"3f8000",
												x"000000",
												x"000000",
												x"000000",
												x"000000",
												x"000000",
												x"1f66a6",
												x"1f66a6",
												x"1f66a6",
												x"1f66a6",
												x"1f66a6",
												x"3efefe",
												x"3efefe",
												x"3efefe",
												x"3efefe",
												x"3efefe",
												x"1f66a6",
												x"3f8000",
												x"1f66a6",
												x"3efefe",
												x"1f66a6",
												x"3efefe",
												x"000000",
												x"3f43c3",
												x"3f8000",
												x"3efefe",
												x"1f66a6",
												x"1f66a6",
												x"3f8000",
												x"3efefe",
												x"1f66a6",
												x"3efefe",
												x"000000",
												x"3f43c3",
												x"3f8000",
												x"3efefe",
												x"1f66a6",
												x"3efefe",
												x"3efefe",
												x"1f66a6",
												x"1f66a6",
												x"3efefe",
												x"000000",
												x"3f43c3",
												x"3f8000",
												x"3efefe",
												x"1f66a6",
												x"1f66a6",
												x"1f66a6",
												x"1f66a6",
												x"1f66a6",
												x"3efefe",
												x"3efefe",
												x"3efefe",
												x"3efefe",
												x"3efefe");
begin
	k00 <= img(to_integer(unsigned(d00)));
	k01 <= img(to_integer(unsigned(d01)));
	k10 <= img(to_integer(unsigned(d10)));
	k11 <= img(to_integer(unsigned(d11)));
end Behavioral;

