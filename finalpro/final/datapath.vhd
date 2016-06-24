----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:25:08 06/24/2016 
-- Design Name: 
-- Module Name:    datapath - rtl 
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

entity datapath is
	port (clk, reset, enqueue, dequeue : in std_logic;
		data_in : in std_logic_vector (15 downto 0);
		data_out : out std_logic_vector (15 downto 0));
end entity;

architecture rtl of datapath is
	component counter
		generic (N : integer := 4);
		port (number : out std_logic_vector (N - 1 downto 0) := (others => '0');
			clk, r, en : in std_logic);
	end component;
	component queue
		port (index : in std_logic_vector;
			remove, mode, clk : in std_logic;
			new_data : in std_logic_vector (15 downto 0);
			tid : out std_logic_vector (15 downto 0));
	end component;
	component controller
		generic (N : integer := 4);
		port (enqueue, dequeue : in std_logic;
			clk, reset : in std_logic;
			counter_reset, counter_enable : out std_logic;
			remove, mode : out std_logic;
			index : out std_logic_vector (N - 1 downto 0);
			counter_index : in std_logic_vector (N - 1 downto 0);
			data_in, tid_in : in std_logic_vector (15 downto 0);
			data_out, tid_out : out std_logic_vector (15 downto 0));
	end component;

	for all:counter use entity work.counter;
	for all:queue use entity work.queue;
	for all:controller use entity work.controller;

	signal counter_enable, counter_reset : std_logic;
	signal counter_index : std_logic_vector (3 downto 0);
	signal remove, mode : std_logic;
	signal index : std_logic_vector (3 downto 0);
	signal tid, new_data : std_logic_vector (15 downto 0);
begin
	cn : counter generic map (4) port map (counter_index, clk, counter_reset, counter_enable);
	co : controller generic map (4) port map (enqueue, dequeue, clk, reset, counter_reset, counter_enable,
		remove, mode, index, counter_index, data_in, tid, data_out, new_data);
	q : queue port map (index, remove, mode, clk, new_data, tid);
end architecture;
