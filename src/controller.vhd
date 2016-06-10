--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   10-06-2016
-- Module Name:   controller.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity controller is
	generic (N : integer := 4);
	port (enqueue, dequeue : in std_logic;
		clk, reset : in std_logic;
		remove, mode : out std_logic;
		index : out std_logic_vector (N - 1 downto 0);
		data_in : in std_logic_vector (15 downto 0);
		data_out : out std_logic_vector (15 downto 0));
end entity;

architecture rtl of controller is
	type state is (RST, EQ0, EQ1, DQ0);
	signal current_state, next_state : state := RST;
begin
	process (clk)
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				current_state <= RST;
			else
				current_state <= next_state;
	end process;
	process (current_state, enqueue, dequeue)
	begin
		case current_state is
			when RST =>
				if enqueue = '1' then
					next_state <= EQ0;
				elsif dequeue = '1' then
					next_state <= DQ0;
				else
					next_state <= RST;
				end if;
			when DQ0 =>
				next_state <= RST;
		end case;
	end process;
	process (current_state)
	begin
		case current_state is
			when RST =>
				index <= (others <= '0');
				remove <= '0';
				mode <= '0';
			when DQ0 =>
				index <= (others <= '1');
				remove <= '1';
				mode <= '0';
		end case;
	end process;
end;
