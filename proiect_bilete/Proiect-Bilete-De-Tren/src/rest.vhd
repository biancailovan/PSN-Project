library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity rest is
	port(suma,clk: in std_logic;
	r: out std_logic);
end rest;

architecture arh of rest is

component reg is
	port (data_in: in std_logic_vector (7 downto 0);
	reset: in std_logic;
	clk: in std_logic;
	data_out: out std_logic_vector (7 downto 0));
end component;

component comparator is
	port(a,b: in std_logic_vector(7 downto 0);
	c:out std_logic_vector(1 downto 0));
end component;

component scazator is
	port(a,b: in std_logic_vector(7 downto 0);
		d : out std_logic_vector(7 downto 0));
end component;

component test is
port (Clk : in std_logic;
        address : in std_logic_vector(2 downto 0);
        we : in std_logic;
		  cs : in std_logic;
        data_i : in std_logic_vector(7 downto 0);
        data_o : out std_logic_vector(7 downto 0)
     );
end component;

signal we,cs,reset: std_logic;
signal data_in,data_out,data_i,data_o: std_logic_vector (7 downto 0);
signal ok: std_logic_vector (1 downto 0);
signal address : std_logic_vector(2 downto 0);
--type ram_t is array (7 downto 0) of std_logic_vector(7 downto 0);
--signal ram : ram_t;
signal ledrest,lederoare,ledbilet: std_logic;

begin
	c1: reg port map (data_in,reset,clk,data_out);
	c2: test port map (clk,address,we,cs,data_i,data_o);
	c3: comparator port map (data_out,data_o,ok);
	process(ok)
	begin
	if(ok="01") then
		lederoare<='1';
		ledrest<='0';
		ledbilet<='0';
	elsif (ok="10") then
		lederoare<='0';
		ledrest<='1';
		ledbilet<='1';
	elsif	(ok="11") then
		lederoare<='0';
		ledrest<='0';
		ledbilet<='1';
	end if;
	end process;
end arh;