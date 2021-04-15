all: loop_rooms clear
loop_rooms: loop_rooms.o
	g++ -Wall -O3 loop_rooms.o -o loop_rooms

loop_rooms.o: loop_rooms.cpp
	g++ -Wall -O3 loop_rooms.cpp -c

clear :
	rm loop_rooms.o 
