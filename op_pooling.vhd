library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity op_pooling is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           start : in  STD_LOGIC;
           result_in : in  STD_LOGIC_VECTOR(23 downto 0);
           wr : out  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR(23 downto 0);
           d00 : out  STD_LOGIC_VECTOR (6 downto 0);
           d01 : out  STD_LOGIC_VECTOR (6 downto 0);
           d10 : out  STD_LOGIC_VECTOR (6 downto 0);
           d11 : out  STD_LOGIC_VECTOR (6 downto 0));
end op_pooling;

architecture Behavioral of op_pooling is

constant lim_ver : natural := 4; -- numero de desplazamientos que realiza verticalmente la ventana sobre la imagen
constant lim_hor : natural := 4; -- numero de desplazamientos que realiza horizontalmente la ventana sobre la imagen
constant row : natural := 10; -- numero de filas
constant col : natural := 10; -- numero de columnas
constant kdim : natural := 2; -- kernel de tamaño 2x2
constant stride : natural := 2; --brinco de la ventana
--registros para extraer valores en RAM IMG
signal d0_reg,d1_reg,d2_reg,d3_reg : unsigned(6 downto 0);
signal d0_next,d1_next,d2_next,d3_next : unsigned(6 downto 0);

--Contadores horizontal y vertical
signal conth_reg, conth_next, contv_reg, contv_next : unsigned(3 downto 0);
type estados is (idle,dot,get_value,shift_hor,shift_ver);
signal state_next, state_reg : estados;

begin
process(clk,rst)
begin
	if (rst = '1') then
		state_reg <= idle;
		d0_reg <= "0000000";
		d1_reg <= "0000001";
		d2_reg <= "0000000" + row;
		d3_reg <= "0000001" + row;
		conth_reg <= x"0";
		contv_reg <= x"0";
	elsif (clk'event and clk = '1') then
		state_reg <= state_next;
		d0_reg <= d0_next;
		d1_reg <= d1_next;
		d2_reg <= d2_next;
		d3_reg <= d3_next;
		conth_reg <= conth_next;
		contv_reg <= contv_next;
	end if;
end process;
-- NEXT STATE --
process(state_reg,d0_reg,d1_reg,d2_reg,d3_reg,conth_reg,contv_reg,start,result_in)

begin
	state_next <= state_reg;
	d0_next <= d0_reg;
	d1_next <= d1_reg;
	d2_next <= d2_reg;
	d3_next <= d3_reg;
	conth_next <= conth_reg;
	contv_next <= contv_reg;
	wr <= '0';
	case state_reg is 
		when idle => 
			if start = '1' then
				state_next <= dot;
				d0_next <= "0000000";
				d1_next <= "0000001";
				d2_next <= "0000000" + row;
				d3_next <= "0000001" + row;
				conth_next <= x"0";
				contv_next <= x"0";
			end if;
		when dot =>
			--envia valores para producto punto
			d00 <= std_logic_vector(d0_reg);
			d01 <= std_logic_vector(d1_reg);
			d10 <= std_logic_vector(d2_reg);
			d11 <= std_logic_vector(d3_reg);
			state_next <= get_value;
		when get_value =>
			--pasa el valor obtenido del producto punto y activa una senal de escritura
			dout <= result_in;
			wr <= '1';
			state_next <= shift_hor;
		when shift_hor =>
			--incrementa los contadores horizontalmente
			conth_next <= conth_reg + 1;
			if conth_reg < lim_hor then
				-- incrementa el contador de la columna
				d0_next <= d0_reg + stride; --avanza de columna
				d1_next <= d1_reg + stride;
				d2_next <= d2_reg + stride;
				d3_next <= d3_reg + stride;
				state_next <= dot;
			else
				state_next <= shift_ver;
				conth_next <= x"0";
			end if;
		when shift_ver =>
			--incrementa los contadores verticalmente
			contv_next <= contv_reg + 1;
			if contv_reg < lim_ver then
				d0_next <= d0_reg + kdim + row; --avanza de fila
				d1_next <= d1_reg + kdim + row;
				d2_next <= d2_reg + kdim + row;
				d3_next <= d3_reg + kdim + row;
				state_next <= dot;
			else
				state_next <= idle;
				contv_next <= x"0";
			end if;
	end case;
end process;



end Behavioral;

