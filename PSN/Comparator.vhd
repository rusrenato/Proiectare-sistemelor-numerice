library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entitate comparator

entity comparator is
port(      nr1 : in std_logic_vector(4 downto 0);  --numarul 1
           nr2 : in std_logic_vector(4 downto 0);  --numarul 2
           stare : out std_logic);   
end comparator;

--arhitectura comparator

architecture comparatorarch of comparator is
begin
process(nr1,nr2)
begin    
	if(nr1 > "10101" and nr2 > "10101") then	-- daca ambii jucatori au peste 21 atunci starea devine 'X'
		stare <= 'X';						   	-- starea 'X' = ambii jucatori au pierdut
	end if;		
	
	if(nr1 > "10101" and nr2<= "10101") then 	-- daca jucatorul 1 are peste 21 jucatorul 2 are <=21 atunci starea devine 1										 --
		stare <= '1';							-- starea '1' = jucatorul 2 a castigat
	end if;
	
	if(nr1<= "10101" and nr2 >"10101" ) then   -- daca jucatorul 2 are peste 21 jucatorul 1 are <=21 atunci starea devine 0
		stare <= '0';						   -- starea '0' = jucatorul 1 a castigat
	end if;	 
	
	if(nr1 = nr2) then 							-- daca ambii jucatori au acelasi nr de puncte atunci starea devine 'X'
		stare <= 'X';							-- starea 'X' = ambii jucatori au pierdut
	end if;
	
	if(nr1 <= "10101" and nr2 <= "10101") then 
		if(nr1 < nr2) then 
			stare<= '1';
		end if;
		if(nr2 < nr1)	then
			stare<= '0';	 
		end if;
	end if;
	
end process;   

end comparatorarch;