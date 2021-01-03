
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pwm_tb is
--  Port ( );
end pwm_tb;

architecture Behavioral of pwm_tb is
  component COUNTER
    Port ( 
          clk	: in std_logic;
          rst	: in std_logic;
          ub	: in std_logic_vector(3 downto 0);
          lb		: in std_logic_vector(3 downto 0);
          cnt1	: out std_logic_vector(3 downto 0);
          cnt2	: out std_logic_vector(3 downto 0);
		pwmclk	: out std_logic
    );
  end component;
  
--declare inputs and initialize them to zero.
constant	clk_period	: time := 10ns;
signal	clk			: std_logic := '0';
signal	rst			: std_logic;
signal	ub			: std_logic_vector(3 downto 0);
signal	lb			: std_logic_vector(3 downto 0);
signal	cnt1			: std_logic_vector(3 downto 0);
signal	cnt2			: std_logic_vector(3 downto 0);
signal	pwmclk	: std_logic;

begin

	rst <= '1', '0' after 10 ns;
	ub <= "1001";
	lb <= "0001";

  uut: COUNTER port map ( clk		=> clk,
                          rst	=> rst,
                          ub	=> ub,
                          lb	=> lb,
                          cnt1	=> cnt1,
                          cnt2	=> cnt2,
                          pwmclk => pwmclk
                          );
                       
  stimulus: process
  begin
    -- Put initialisation code here
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
    -- Put test bench stimulus code here
--    wait;
  end process;
  
end Behavioral;
