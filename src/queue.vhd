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
		remove, mode, clk : in std_logic;
		new_data : in std_logic_vector (15 downto 0);
		tid : out std_logic_vector (15 downto 0));
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

	type queue_data is array (natural range <>) of std_logic_vector (15 downto 0);

	constant cells_nr : integer := 2 ** index'length;

	signal empty : std_logic_vector (cells_nr downto 0);
	signal removes : std_logic_vector (cells_nr - 1 downto 0);
	signal tids : queue_data (cells_nr downto 0);
	signal new_datas : queue_data (cells_nr - 1 downto 0);
	signal mux : std_logic;

	for all:sr_cell use entity sr_cell;
begin
	empty (cells_nr) <= '0';
	for I in 0 to cells_nr - 1 generate
		cells : sr_cell port map(open, new_datas (I), tids (I + 1), tids (I), clk,
			removes (I), empty (I + 1), empty (I), mux);
	end generate
	process (clk)
	begin
		if clk'event and clk = '1' then
			mux <= mode;
			tid <= tids (to_integer(unsigned(index));
			new_datas (to_integer(unsigned(index))) <= new_data;
		end if;
	end process;
end architecture;
