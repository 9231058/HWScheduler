--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   06-06-2016
-- Module Name:   sr-cell.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sr_cell is
	generic (N : integer := 16)
	port (left_data, new_data, right_data : in std_logic_vector (N - 1 downto 0);
		clk, remove, next_empty : in std_logic;
		empty : out std_logic;
		mux_data : in std_logic_vector (1 downto 0));
end entity;

architecture rtl of sr_cell is
begin
	process (clk)
	begin
		if clk'event and clk = '1' then
		end if;
	end process;
end architecture;
