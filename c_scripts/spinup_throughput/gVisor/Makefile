CC = gcc
WARNING_FLAGS = -Wall -Wextra
EXE = spinup

clean:
	rm -f $(EXE) *.o

spinup: clean spinup.o
	$(CC) -pthread -o $(EXE) spinup.o

spinup.o: spinup.c
	$(CC) $(WARNING_FLAGS) -c spinup.c
