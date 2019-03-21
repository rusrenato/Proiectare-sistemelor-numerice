------Unitate de executie ----		  
	
library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use IEEE.STD_LOGIC_UNSIGNED.all;
	
------Entitate unitate------
	
entity unitate is 
	port (	START_AUTOMAT,CLK,SELECTARE_JUCATOR,DORESC1,DORESC2,RESETARE : in STD_LOGIC;
			CASTIGATOR_JOC : out STD_LOGIC );
	end entity ;

------Arhitectura unitatii-----
	
architecture comportamental of unitate is 
	
--Componente
	--1.Sumator
	  
component sumator is
	 port (  NR1 : in  STD_LOGIC_VECTOR (4 downto 0) := "00000";
             NR2 : in  STD_LOGIC_VECTOR (4 downto 0) := "00000";
             SUMA : out  STD_LOGIC_VECTOR (4 downto 0)); 
end component;
--2.Comparator 
	  
component comparator is 
	  port (  NR1 : in std_logic_vector(4 downto 0); 
           	  NR2 : in std_logic_vector(4 downto 0);  
       		  stare : out std_logic); 	   
end component;
		   
 --3.Generator 
	  
 component generator is 
	 port ( RESET,CLK : in STD_LOGIC;
    		Dout : out STD_LOGIC_VECTOR (3 downto 0));		   	 
end component;	

	  
	  
	  signal Carte : std_logic_vector(3 downto 0);      
	  signal enable1 : std_logic := '1';	--semnal activ pe 1 , cand devine 0 jucatorul 1 nu mai primeste carti
	  signal enable2 : std_logic := '1';	--semnal activ pe 1 , cand devine 0 jucatorul 2 nu mai primeste carti	  
	  signal Puncte_1 : std_logic_vector(4 downto 0) := "00000";  
	  signal Puncte_2 : std_logic_vector(4 downto 0) := "00000"; 
	  signal Punctaj_1 : integer range 0 to 50;
	  signal Punctaj_2 : integer range 0 to 50; 

	  begin
		
	 
	
generez: generator port map(START_AUTOMAT,CLK,Carte); 		
	
	
	
	p1:process(Carte)		  -- primul jucator
	variable suma1: std_logic_vector(4 downto 0):= "00000";
	variable valmin: std_logic_vector(4 downto 0):= "10100"; --varibila pt setare suma minima
	begin	 
		
		if(enable1 = '1' and doresc1 = '0' ) then
			if(selectare_jucator = '0' and (doresc1 = '0' or suma1< "01111") ) then 	  
			   	if(carte /= "UUUU") then 	   --cartea este initializata
				suma1 := suma1 + ('0' & carte);		 
				puncte_1<= suma1;  		
				end if;
			end if;	
			if(doresc1 = '1' and suma1> valmin) then
				enable1<= '0';
			end if;	 
			if(suma1 >= "10101") then 
				enable1 <= '0';
			end if;	 
			end if;
			if (resetare = '1') then 
				enable1 <= '1';
				suma1 := "00000"; 
			
			end if;	 
		puncte_1 <= suma1;
	end process;	   
	
	p2:process(Carte)	   -- al doilea jucator
	variable suma2: std_logic_vector(4 downto 0):= "00000";	
	variable valmin2: std_logic_vector(4 downto 0):= "10100";	  --varibila pt setare suma minima
	begin
		if(enable2 = '1' and doresc2 = '0') then
			if(selectare_jucator = '1' and doresc2 = '0' ) then   
			   	if(carte /= "UUUU") then --cartea este initializata
				suma2 := suma2 + ('0' & carte);
				puncte_2 <= suma2;
				end if;
			end if;	
			if(doresc2 = '1' and suma2 > valmin2) then
				enable2<= '0'; 
	        end if;	 		  
			
			if(suma2 >= "10101") then 
				enable2<= '0';	 
		    end if;		   
			 end if;
			if (resetare = '1') then 
				enable2 <= '1';
				suma2 := "00000";
				end if;
				puncte_2<= suma2;	
			
		end process;	   
	
	 
	
	p3: comparator port map(puncte_1,puncte_2,castigator_joc); 	
	
	Punctaj_1<= conv_integer(puncte_1);
	Punctaj_2<= conv_integer(puncte_2);
	
	
	  
end comportamental;								

