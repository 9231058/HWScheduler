--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   06-06-2016
-- Module Name:   queue.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity queue is
	port (index : in std_logic_vector;
		remove : in std_logic;
		mode : in std_logic);
end entity;

architecture rtl of queue is
	component sr_cell
		generic (N : integer := 16)
		port (left_data, new_data, right_data : in std_logic_vector (N - 1 downto 0);
			tid : out std_logic_vector (N - 1 downto 0);
			clk, remove, next_empty : in std_logic;
			empty : out std_logic;
			mux_data : in std_logic);
	end component;

	constant cells_nr : integer := 2 ** index'length;

	signal empty : std_logic_vector (cells_nr - 1 downto 0);
	signal mux : std_logic_vector (cells_nr - 1 downto 0);

	for all:sr_cell use entity sr_cell;
begin
	for I in cells_nr - 1 downto 0 generate
		cells : sr_cell();
	end generate
end architecture;
