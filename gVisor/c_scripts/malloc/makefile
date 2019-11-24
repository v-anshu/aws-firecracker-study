CC = g++
WARNING_FLAGS =  -std=c++0x
EXE = malloc

all: clean main.o
	$(CC) -o $(EXE) -std=c++0x main.o
main.o: main.cpp
	$(CC) $(WARNING_FLAGS) -c main.cpp
clean:
	rm -f $(EXE) *.o