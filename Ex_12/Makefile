all: loop_rooms clear
loop_rooms: loop_rooms.o
	g++ loop_rooms.o -o loop_rooms

loop_rooms.o: loop_rooms.cpp
	g++ loop_rooms.cpp -c

clear :
	rm loop_rooms.o 
