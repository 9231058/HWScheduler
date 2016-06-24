----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:29:06 06/24/2016 
-- Design Name: 
-- Module Name:    sr_cell - rtl 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity sr_cell is
	generic (N : integer := 16)
	port (left_data, new_data, right_data : in std_logic_vector (N - 1 downto 0);
		tid : out std_logic_vector (N - 1 downto 0);
		clk, remove, next_empty : in std_logic;
		empty : out std_logic;
		mux_data : in std_logic);
end entity;

architecture rtl of sr_cell is
	signal reg_tid : std_logic_vector (N - 1 downto 0);
	signal reg_new_data : std_logic_vector (N - 1 downto 0);
begin
	tid <= reg_tid;
	process (clk)
	begin
		if clk'event and clk = '1' then
			if remove = '1' then
				case mux_data is
					when '0' =>
						empty <= '1';
						reg_new_data <= left_data;
					when '1' =>
						empty <= '1';
						reg_new_data <= new_data;
				end case;
			else
				empty <= '0';
				reg_tid <= reg_new_data;
			end if;
			if next_empty = '1' then
				case mux_data is
					when '0' =>
						empty <= '1';
						reg_new_data <= left_data;
					when '1' =>
						empty <= '1';
						reg_new_data <= right_data;
				end case;
			else
				reg_tid <= reg_new_data;
				empty <= '0';
			end if;
		end if;
	end process;
end architecture;
