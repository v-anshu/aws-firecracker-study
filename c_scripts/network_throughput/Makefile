CC = gcc
WARNING_FLAGS = -Wall -Wextra
EXE = net

clean:
	rm -f $(EXE) *.o

net: clean net.o
	$(CC) -o $(EXE) net.o

net.o: net.c
	$(CC) $(WARNING_FLAGS) -c net.c
