library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity Geterodin_module is
    port (
        Clk   : in std_logic;
        nRst: in std_logic;
        ReceiveDataMode: in std_logic;
		  DataStrobe: in std_logic;

        ISig_In: in std_logic_vector(9 downto 0);
		  QSig_In: in std_logic_vector(9 downto 0);
		  
		  FS_IncrDecr: in std_logic_vector(1 downto 0);

        IData_Out: out std_logic_vector(9 downto 0);
        QData_Out: out std_logic_vector(9 downto 0);

        DataValid: out std_logic
    );
end entity;


architecture geterodin_arch of Geterodin_module is
    signal DataValid_temp: std_logic;
    signal I_temp : std_logic_vector(9 downto 0);
    signal Q_temp : std_logic_vector(9 downto 0);
    signal I_received: std_logic;
begin
    IData_Out <= I_temp;
    QData_Out <= Q_temp;

    DataValid <= DataValid_temp;


    SignalSeparation: process (nRst, Clk)
    begin
        if (nRst = '0') then
            I_temp <= (others => '-');
            Q_temp <= (others => '-');

            DataValid_temp <= '0';
            I_received <= '0';
        elsif rising_edge(Clk) then
            if (ReceiveDataMode = '1') then
                I_temp <= ISig_in;
                Q_temp <= QSig_in;
                DataValid_temp <= '1';
            elsif (I_received = '0') then
                I_temp <= ISig_in;
                DataValid_temp <= '0';
                I_received <= '1';
            else 
                Q_temp <= ISig_in;
                DataValid_temp <= '1';
                I_received <= '0';
            end if;
        end if;
    end process;

end architecture;