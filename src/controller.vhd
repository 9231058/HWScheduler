--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   10-06-2016
-- Module Name:   controller.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity controller is
	port (enqueue, dequeue : in std_logic;
		clk, reset : in std_logic;
		data_in : in std_logic_vector (15 downto 0);
		data_out : out std_logic_vector (15 downto 0));
end entity;

architecture rtl of controller is
	type state is (RST, EQ0, EQ1, DQ0, DQ1);
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
		end case;
	end process;
end;
