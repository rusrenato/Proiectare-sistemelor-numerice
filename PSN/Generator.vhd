-----------------Generator de numere pseudoaleatoare-----------

-------Registru universal-----------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

----Entitate registru----
entity registru is 
	port ( CLK,RESET,LOAD,ST,DR,SI : in STD_LOGIC;
	DIN : in STD_LOGIC_VECTOR (0 to 3);
	DOUT : out STD_LOGIC_VECTOR (0 to 3));
end;

---Arhitectura registru---
architecture registruarch of registru is 
signal M: STD_logic_vector ( 0 to 3);
begin	   
	process (CLK)
	begin
		if (CLK='1') and (CLK'EVENT) then 
			if (RESET='1') then 
				M <= "0000"; ----- Resetare
			elsif (LOAD='1') then 
				M <= DIN;	------ Incarcare paralela
			elsif (DR='1')	then 
				M(0 to 2) <= M(1 to 3);  ---- Deplasare dreapta
				M(3)<= SI;
		    elsif (ST='1')	then 	 
				M(1 to 3) <= M(0 to 2);	---- Deplasare stanga
				M(0) <= SI;		
			end if;
		end if;
 end process;
 DOUT<=M;	   
 end registruarch;
 
 
 
 ----- Poarta XNOR -----		  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-----Entitate xnor-----
entity XNOR1 is 
	port ( A,B : in STD_LOGIC;
	       Y : out STD_LOGIC);
end;
-----Arhitectura----
architecture xnor1arch of XNOR1 is
begin
	Y <= A Xnor B;
end xnor1arch;



------------Generatorul-----------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

---Entitate generator------

entity generator is
	port (	RESET,CLK : in STD_LOGIC;
			DOUT:out STD_LOGIC_VECTOR (3 downto 0));
end entity;

-----Arhitectura generator-----

architecture generatorarch of generator is

--Componente :	

--1.Registrul Universal 
  
component registru is 
	port (	CLK,LOAD,ST,DR,RESET,SI : in STD_LOGIC;
			DIN : in STD_LOGIC_VECTOR (0 to 3);
			DOUT : out STD_LOGIC_VECTOR (0 to 3));
end component ;

--2.Poarta XOR

component XNOR1 is 
	port  (	A,B : in STD_LOGIC;
			Y: out STD_LOGIC);
end component;
 

signal X:STD_LOGIC;
signal Y:STD_LOGIC_VECTOR (0 to 3);
signal valoare: STD_LOGIC_VECTOR (0 to 3);
--port map-ul 
begin
	reg : registru port map (CLK => CLK,
	                         LOAD =>RESET,
							 ST => '0',
							 DR => '1',
 							 RESET => '0',
 							 SI => X,
							 DIN => "0001",
							 Dout => Y);
	Xor1 : XNOR1 port map (Y(0),Y(3),X);
	
  p:process(Y)	 --conditii pentru generare
  begin			  
	  if (Y="1111") then 	   
		 	 valoare <="1010";  
		elsif(Y="0001") then
			valoare<="0010"; 
		elsif(Y="0000") then
			valoare<="0010";
	  	elsif  (Y<"1111" and Y>"0001") then 
		  	valoare <=Y;
		  
	  end if;	
	 end process;
	DOUT<=valoare;	
	
end generatorarch ;
	  
		  