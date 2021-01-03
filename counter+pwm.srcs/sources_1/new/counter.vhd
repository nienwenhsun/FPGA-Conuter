
-- 糤筿隔
-- if 璸计竟1计 then
-- => PWM = 0
-- => 璸计竟2计
-- if 璸计竟2计 then
-- => PWM = 1
-- => 璸计竟1计
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pwm is
  Port ( 
	clk		: in std_logic;
	rst		: in std_logic;
	ub		: in std_logic_vector(3 downto 0);		-- upper bound
	lb		: in std_logic_vector(3 downto 0);		-- lower bound
	cnt1		: out std_logic_vector(3 downto 0);		-- counter1
	cnt2		: out std_logic_vector(3 downto 0);		-- counter2
	pwmclk	: out std_logic						-- PWM
  );
end pwm;

architecture Behavioral of pwm is
    signal Q1		: std_logic_vector(3 downto 0);
    signal Q2		: std_logic_vector(3 downto 0);
	signal STATE		: std_logic;
begin
	cnt1 <= Q1;
	cnt2 <= Q2;
	pwmclk <= STATE;

-- Τ篈诀
-- FSM(Finite State Machine)
	FSM:	process(clk, rst)	--> 1 => 计 , 0 => 计
    begin
    	if rst = '1' then	
    		STATE <= '1';
        elsif rising_edge(clk) then
        	case STATE is
        		when '1' =>
        			if Q1 = "1000" then STATE <= '0';
        			end if;
        		when '0' =>
        			if Q2 = "0010" then STATE <= '1';
        			end if;
        		when others =>
        			null;
        	end case;
        end if;
	end process;
	
	counter1:		process(clk, rst, STATE) --> count1计
    begin
    	if rst = '1' then
    		Q1 <= lb;
        elsif rising_edge(clk) then
        	if STATE = '1' then	Q1 <= Q1 + 1;
        	else					Q1 <= lb;
			end if;
        end if;
	end process;
	
	counter2:		process(clk, rst, STATE) --> count2计
    begin
    	if rst = '1' then
    		Q2 <= ub;
        elsif rising_edge(clk) then
        	if STATE = '0' then	Q2 <= Q2 - 1;
        	else					Q2 <= ub;
			end if;
        end if;
	end process;
    
end Behavioral;
