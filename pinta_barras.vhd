--------------------------------------------------------------------------------
-- Felipe Machado Sanchez
-- Departameto de Tecnologia Electronica
-- Universidad Rey Juan Carlos
-- http://gtebim.es/~fmachado
--
-- Pinta barras para la XUPV2P

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library WORK;
use WORK.VGA_PKG.ALL; 

entity pinta_barras is
  Port (
    -- In ports
    visible      : in std_logic;
    clk      : in std_logic;
    col          : in unsigned(10-1 downto 0);
    fila         : in unsigned(10-1 downto 0);
    
    pacman_col: in unsigned(4 downto 0);
    pacman_fila: in unsigned(4 downto 0);
    dato_memo_pacman: in unsigned(15 downto 0);
    dato_memo_racetrack: in unsigned(31 downto 0);
    
    fantasma_col: in unsigned(4 downto 0);
    fantasma_fil: in unsigned(4 downto 0);
    dato_memo_fantasma: in unsigned(15 downto 0);
    -- Out ports
    RGB :out unsigned(11 downto 0);
    addr_memo_pacman :out unsigned(3 downto 0);-- diferentes longitudes de vector del addr para cada memoria pero solo una salida del addr
    addr_memo_racetrack :out unsigned(4 downto 0);
    addr_memo_fantasma :out unsigned(3 downto 0));
end pinta_barras;

architecture behavioral of pinta_barras is

constant c_bar_width : natural := 64;
  
  
signal col_cuad:unsigned(4 downto 0);
signal fila_cuad:unsigned(4 downto 0);


signal col_and:std_logic;
signal fila_and:std_logic;
signal sel_mux:unsigned(3 downto 0);
signal puntuacion:unsigned(3 downto 0);

signal en_mux:std_logic;
signal entrada_mux:std_logic;
signal entrada_mux_fantasma:std_logic;
signal fpuntu:std_logic;
--signal RGB:unsigned(11 downto 0);
signal selector:unsigned(1 downto 0);
signal RGB_sel:std_logic;
signal RGB_sel_rt:std_logic;
signal RGB_sel_fantas:std_logic;
constant color_laberinto_const:std_logic_vector(11 downto 0):="111111111111";
constant color_pacman_const:std_logic_vector(11 downto 0):="000011110000";
constant color_fantasma:std_logic_vector(11 downto 0):="000011110000";
constant color_interseccion:std_logic_vector(11 downto 0):="000011110000";

begin

col_cuad<=col(8 downto 4);
fila_cuad<=fila(8 downto 4);


  P_pinta: Process (visible, col, fila)
  begin
  
     rgb(11 downto 8) <= (others=>'0');
     rgb(7 downto 4)  <= (others=>'0');
     rgb(3 downto 0)  <= (others=>'0');
     
    if visible = '1' then
    
      if col(3 downto 0)="0000" or fila(3 downto 0)="0000" then --pinta la cuadricula(las rayas de negro)
        rgb(11 downto 8)   <= (others=>'0');
        rgb(7 downto 4)  <= (others=>'0');
        rgb(3 downto 0)   <= (others=>'0');
        
      elsif col >"0111111111" then
        rgb(11 downto 8)   <= (others=>'0');
        rgb(7 downto 4)  <= (others=>'0');
        rgb(3 downto 0)   <= (others=>'0');
        
--elsif pacman_col = col_cuad and pacman_fila = fila_cuad then
      elsif  entrada_mux ='1' then
--        en_mux <= '1';
--        selector <= '0' & en_mux;--el cero será la salida de otra and
        
--        case selector is
--            when "00" => RGB <= color_laberinto_const;
--            when "01" => RGB <= color_pacman_const;
--            when "10" => RGB <= color_fantasma;
--            when "11" => RGB <= color_interseccion;
--            when others => RGB <= "000000000000";
--        end case;

      --PACMAN  
        case RGB_sel is
            when '1' =>
                rgb(11 downto 8) <= "1111";
                rgb(7 downto 4)  <= "1111";
                rgb(3 downto 0)  <= "1111";
            when others =>
                rgb(11 downto 8) <= "0000";
                rgb(7 downto 4)  <= "1111";
                rgb(3 downto 0)  <= "0000";
        end case;
        --CIRCUITO
        elsif  RGB_sel_rt ='0' then
            rgb   <= (others=>'0');

        --FANTASMA
        elsif entrada_mux_fantasma='1' then
        case RGB_sel_fantas is
            when '1' =>
                rgb(11 downto 8) <= "1111";
                rgb(7 downto 4)  <= "0000";
                rgb(3 downto 0)  <= "0000";
            when others =>
                rgb(11 downto 8) <= "1111";
                rgb(7 downto 4)  <= "1111";
                rgb(3 downto 0)  <= "1111";
        end case;
        

        
      else
        rgb   <= (others=>'1');
    end if;
    end if;
  end process;
  
    process(clk)-- proceso que
    begin
       if clk'event and clk='1' then
          sel_mux <= col(3 downto 0);
          addr_memo_pacman <= fila(3 downto 0);
          addr_memo_fantasma <= fila(3 downto 0);
          addr_memo_racetrack<=fila(8 downto 4);
       end if;
    end process;
    
    process(clk)
    begin
       if clk'event and clk='1' then
          if pacman_col = col_cuad and pacman_fila = fila_cuad then
            entrada_mux <='1';
          else 
            entrada_mux <='0';
          end if;
       end if;
    end process;
    

    process(clk)
    begin
       if clk'event and clk='1' then
          if fantasma_col = col_cuad and fantasma_fil = fila_cuad then
            entrada_mux_fantasma <='1';
          else 
            entrada_mux_fantasma <='0';
          end if;
       end if;
    end process;    
   
    ---se dibuja el pacman----
    process (sel_mux,dato_memo_pacman)
    begin
        case sel_mux is
            when "0000" => RGB_sel <= dato_memo_pacman(15);
            when "0001" => RGB_sel <= dato_memo_pacman(14);
            when "0010" => RGB_sel <= dato_memo_pacman(13);
            when "0011" => RGB_sel <= dato_memo_pacman(12);
            when "0100" => RGB_sel <= dato_memo_pacman(11);
            when "0101" => RGB_sel <= dato_memo_pacman(10);
            when "0110" => RGB_sel <= dato_memo_pacman(9);
            when "0111" => RGB_sel <= dato_memo_pacman(8);
            when "1000" => RGB_sel <= dato_memo_pacman(7);
            when "1001" => RGB_sel <= dato_memo_pacman(6);
            when "1010" => RGB_sel <= dato_memo_pacman(5);
            when "1011" => RGB_sel <= dato_memo_pacman(4);
            when "1100" => RGB_sel <= dato_memo_pacman(3);
            when "1101" => RGB_sel <= dato_memo_pacman(2);
            when "1110" => RGB_sel <= dato_memo_pacman(1);
            when "1111" => RGB_sel <= dato_memo_pacman(0);
            when others => RGB_sel <= '0';
        end case;
        end process;
  
  
  
  -------se dibuja la pista de carreras-------
    process (col_cuad,dato_memo_racetrack)
    begin
        case col_cuad is
            when "00000" => RGB_sel_rt <= dato_memo_racetrack(31);
            when "00001" => RGB_sel_rt <= dato_memo_racetrack(30);
            when "00010" => RGB_sel_rt <= dato_memo_racetrack(29);
            when "00011" => RGB_sel_rt <= dato_memo_racetrack(28);
            when "00100" => RGB_sel_rt <= dato_memo_racetrack(27);
            when "00101" => RGB_sel_rt <= dato_memo_racetrack(26);
            when "00110" => RGB_sel_rt <= dato_memo_racetrack(25);
            when "00111" => RGB_sel_rt <= dato_memo_racetrack(24);
            when "01000" => RGB_sel_rt <= dato_memo_racetrack(23);
            when "01001" => RGB_sel_rt <= dato_memo_racetrack(22);
            when "01010" => RGB_sel_rt <= dato_memo_racetrack(21);
            when "01011" => RGB_sel_rt <= dato_memo_racetrack(20);
            when "01100" => RGB_sel_rt <= dato_memo_racetrack(19);
            when "01101" => RGB_sel_rt <= dato_memo_racetrack(18);
            when "01110" => RGB_sel_rt <= dato_memo_racetrack(17);
            when "01111" => RGB_sel_rt <= dato_memo_racetrack(16);
            when "10000" => RGB_sel_rt <= dato_memo_racetrack(15);
            when "10001" => RGB_sel_rt <= dato_memo_racetrack(14);
            when "10010" => RGB_sel_rt <= dato_memo_racetrack(13);
            when "10011" => RGB_sel_rt <= dato_memo_racetrack(12);
            when "10100" => RGB_sel_rt <= dato_memo_racetrack(11);
            when "10101" => RGB_sel_rt <= dato_memo_racetrack(10);
            when "10110" => RGB_sel_rt <= dato_memo_racetrack(9);
            when "10111" => RGB_sel_rt <= dato_memo_racetrack(8);
            when "11000" => RGB_sel_rt <= dato_memo_racetrack(7);
            when "11001" => RGB_sel_rt <= dato_memo_racetrack(6);
            when "11010" => RGB_sel_rt <= dato_memo_racetrack(5);
            when "11011" => RGB_sel_rt <= dato_memo_racetrack(4);
            when "11100" => RGB_sel_rt <= dato_memo_racetrack(3);
            when "11101" => RGB_sel_rt <= dato_memo_racetrack(2);
            when "11110" => RGB_sel_rt <= dato_memo_racetrack(1);
            when "11111" => RGB_sel_rt <= dato_memo_racetrack(0);

            when others => RGB_sel <= '0';
        end case;
end process;

       process (sel_mux,dato_memo_fantasma)
        begin
        case sel_mux is
            when "0000" => RGB_sel_fantas <= dato_memo_fantasma(15);
            when "0001" => RGB_sel_fantas <= dato_memo_fantasma(14);
            when "0010" => RGB_sel_fantas <= dato_memo_fantasma(13);
            when "0011" => RGB_sel_fantas <= dato_memo_fantasma(12);
            when "0100" => RGB_sel_fantas <= dato_memo_fantasma(11);
            when "0101" => RGB_sel_fantas <= dato_memo_fantasma(10);
            when "0110" => RGB_sel_fantas <= dato_memo_fantasma(9);
            when "0111" => RGB_sel_fantas <= dato_memo_fantasma(8);
            when "1000" => RGB_sel_fantas <= dato_memo_fantasma(7);
            when "1001" => RGB_sel_fantas <= dato_memo_fantasma(6);
            when "1010" => RGB_sel_fantas <= dato_memo_fantasma(5);
            when "1011" => RGB_sel_fantas <= dato_memo_fantasma(4);
            when "1100" => RGB_sel_fantas <= dato_memo_fantasma(3);
            when "1101" => RGB_sel_fantas <= dato_memo_fantasma(2);
            when "1110" => RGB_sel_fantas <= dato_memo_fantasma(1);
            when "1111" => RGB_sel_fantas <= dato_memo_fantasma(0);
            when others => RGB_sel_fantas <= '0';
        end case;
        end process;
        

--img_incol<=pos_col_cuad-pacman_col;
--img_infila<=pos_fila_cuad-pacman_fila;


--col_and<= '1' when pos_col_cuad = col_cuad else '0';
--fila_and<= '1' when pos_fila_cuad = fila_cuad else '0';

--en_mux <= col_and and fila_and;
--in_mux<=img_incol and img_infila;



--color_pavman <= red & green & blue de pacman
--selector <= '0' & en_mux;--el cero será la salida de otra and
--process (selector,color_fondo,color_pacman,color_fantasma,color_interseccion)
--begin
--   case selector is
--      when "00" => RGB <= color_fondo;
 --     when "01" => RGB <= color_pacman;
--      when "10" => RGB <= color_fantasma;
--      when "11" => RGB <= color_interseccion;
--      when others => RGB <= "000000000000";
--   end case;
--end process;
    
end Behavioral;

