-------------------------------------------------------------------------------
-- Hector Garcia
-- seven_seg_counter
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;     

entity seven_seg_counter is
  port (
	clk                : in  std_logic;
	reset              : in std_logic;
    output_dis         : out  std_logic_vector(6 DownTo 0)
  );
end seven_seg_counter;

architecture beh of seven_seg_counter  is
	signal sum_A        : std_logic_vector(3 downto 0) := "0000";
	signal sum_sig      : std_logic_vector(3 downto 0) := "0000";
	signal enable_sig   : std_logic;  
	
	component generic_adder_beh
		port(
		    a       : in  std_logic_vector(3 downto 0);
			b       : in  std_logic_vector(3 downto 0);
			cin     : in  std_logic;
			sum     : out std_logic_vector(3 downto 0);
			cout    : out std_logic
		);
	end component;
	
	component generic_counter
		generic (
		max_count : integer := 3
		);
		port(
			clk             : in  std_logic; 
			reset           : in  std_logic;
            output          : out std_logic
		);
	end component;
	
	component seven_seg_display
		port (
			clk                : in  std_logic;
			reset              : in std_logic;
			bcd                : in  std_logic_vector(3 DownTo 0); 
			seven_seg_out      : out  std_logic_vector(6 DownTo 0)
		);
	end component;
	
begin
	
	counter : generic_adder_beh 
	Port map(
		b    => "0001",
		a    => sum_sig,
		cin  =>  '0', 
		sum  => sum_A,  
		cout =>  open
	);
	
	enabler : generic_counter 
	generic map(
	max_count => 50000000
	)
	Port map(
		clk     => clk,
		reset   => reset,
		output  => enable_sig
	);
	
	seven_seg : seven_seg_display 
	Port map(
		clk 	      => clk,
		reset  	      => reset,
		bcd  	      => sum_sig, 
		seven_seg_out => output_dis
	);
	
	process(clk, reset)
	begin 
	if(reset = '1') then 
		sum_sig <= "1111";
	elsif(clk'event and clk = '1') then 
		if(enable_sig = '1')then 
			sum_sig <= sum_A;
		--elsif(enable_sig = '1') then 
		--sum_dis <= sum + "0001";
		end if;
	end if;
	end process;
	
end beh;
