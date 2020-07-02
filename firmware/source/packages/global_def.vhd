--------------------------------------------------------------------------------
-- Title       : DWA Global Definitions
-- Project     : DUNE DWA
--------------------------------------------------------------------------------
-- File        : headerGenerator.vhd
-- Author      : Nathan Felt felt@fas.harvard.edu
-- Company     : Harvard University LPPC
-- Created     : Thu May  2 11:04:21 2019
-- Last update : Wed Jul  1 23:06:58 2020
-- Platform    : DWA microZed
-- Standard    : VHDL-2008
-------------------------------------------------------------------------------
-- Description: Definitions of a parameterized system
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;

library duneDwa;

package global_def is
    function bool2Sl(BOOL_IN : boolean) return std_logic;
    -- ADC AXI offset address
    constant adcRegOfst  : integer := 24;
    constant adcStatAddr : integer := 23;
    constant useAdcEmu   : boolean := true;

    type SLV_VECTOR_TYPE is array (natural range <>) of std_logic_vector;
    type UNSIGNED_VECTOR_TYPE is array (natural range <>) of unsigned;
    type SIGNED_VECTOR_TYPE is array (natural range <>) of signed;
    type INTEGER_VECTOR_TYPE is array (natural range <>) of integer;

    type toDaqRegType is record
        ctrlBusy    : boolean; --nf
        udpDataWord : std_logic_vector(31 downto 0);
        udpDataRdy  : boolean;
    end record; -- toDaqRegType

    type fromDaqRegType is record
        reset     : boolean;
        auto      : boolean;
        ctrlStart : boolean;
        coilDrive : std_logic_vector(31 downto 0);

        -- start james' additions
        --- which register is this data coming from? (A, F, C, D, E, 0-7)
        --dataRegister       : std_logic_vector(7 downto 0);
        --- dwaCtrl (still used?  how many bits?)
        fixedPeriod    : unsigned(23 downto 0); -- 10ns
        stimPeriodReq  : unsigned(23 downto 0); --nf
        stimPeriodMin  : unsigned(23 downto 0); -- 10ns
        stimPeriodMax  : unsigned(23 downto 0); -- 10ns
        stimPeriodStep : unsigned(23 downto 0); -- 10ns

        --stimPeriodActive   : unsigned(23 downto 0);
        --stimPeriodCounter  : unsigned(23 downto 0); -- bits???
        --- Number of stimulus cycles per frequency (unitless)
        cyclesPerFreq : unsigned(23 downto 0);      -- bits???
                                                    --- Number of ADC samples per simulus cycle (unitless)
        adcSamplesPerCycle : unsigned(15 downto 0); -- bits???
                                                    --- AC Stimulus magnitude (12bit DAC value)
        acStim_mag : unsigned(11 downto 0);
        -- Client IP address (where UDP data is sent)
        clientIp : unsigned(31 downto 0);
        --- After switching to a new frequency, how long to wait before
        --- acquiring data (24bits, units=1.28 microseconds)
        stimTime : unsigned(23 downto 0);
        --- Channel mask indicating which sense channels are active (8bit)
        activeChannels : std_logic_vector(7 downto 0);
        --- Mask indicating which relays are active
        --- in v2 this is 32 bits.  In v3 will be 192 bits!!!
        relayMask : std_logic_vector(31 downto 0);
    --adcSamplingPeriod  : unsigned(23 downto 0);
    -- James' entries end
    end record; -- fromDaqRegType

end global_def;


package body global_def is

    function bool2Sl (BOOL_IN : boolean) return std_logic is
        variable SL_OUT : std_logic;
    begin
        if BOOL_IN then
            SL_OUT := '1';
        else
            SL_OUT := '0';
        end if;
        return SL_OUT;
    end function BOOL2SL;

end global_def;