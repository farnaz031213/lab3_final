---------------------------------------------------------------------------
-- mux_2to1_4b.vhd - 4-bit 2-to-1 Multiplexer Implementation
--
--
-- Copyright (C) 2006 by Lih Wen Koh (lwkoh@cse.unsw.edu.au)
-- All Rights Reserved. 
--
-- The single-cycle processor core is provided AS IS, with no warranty of 
-- any kind, express or implied. The user of the program accepts full 
-- responsibility for the application of the program and the use of any 
-- results. This work may be downloaded, compiled, executed, copied, and 
-- modified solely for nonprofit, educational, noncommercial research, and 
-- noncommercial scholarship purposes provided that this notice in its 
-- entirety accompanies all copies. Copies of the modified software can be 
-- delivered to persons who use it solely for nonprofit, educational, 
-- noncommercial research, and noncommercial scholarship purposes provided 
-- that this notice in its entirety accompanies all copies.
--
---------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity set_write_addr is
    port ( clk: in std_logic; 
           IF_ID : in  std_logic_vector(3 downto 0);
           data_a     : in  std_logic_vector(3 downto 0);
           data_b     : in  std_logic_vector(3 downto 0);
           data_out   : out std_logic_vector(3 downto 0) );
end set_write_addr;

architecture structural of set_write_addr is
signal m: std_logic;
constant OP_ADD   : std_logic_vector(3 downto 0) := "1000";
constant OP_SLL   : std_logic_vector(3 downto 0) := "0100";


begin

    -- this for-generate-loop replicates four single-bit 2-to-1 mux
    process(clk)
    begin
    
    if (rising_edge(clk)) then
        if IF_ID = OP_ADD or IF_ID = OP_SLL then
            m    <= '1';
        else 
            m <= '0';
        end if ;
    end if;
    
    if (falling_edge(clk)) then
--        muxes : for i in 3 downto 0 generate
--            bit_mux : mux_2to1_1b 
--            port map ( mux_select => mux_sel,
--                       data_a     => data_a(i),
--                       data_b     => data_b(i),
--                       data_out   => data_out(i) );
--        end generate muxes;
        if (m = '1') then
            data_out <= data_b;
        else 
            data_out <= data_a;
        end if;
    end if;
    end process;
    
end structural;
