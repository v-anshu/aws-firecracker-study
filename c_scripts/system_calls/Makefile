CC = gcc
WARNING_FLAGS = -Wall -Wextra
EXE_TIME = gettimeofday
EXE_PID = getpid

gettimeofday: clean gettimeofday.o
        $(CC) -o $(EXE_TIME) gettimeofday.o

gettimeofday.o:
        $(CC) $(WARNING_FLAGS) -c gettimeofday.c

getpid: clean getpid.o
		$(CC) -o $(EXE_PID) getpid.o

getpid.o:
        $(CC) $(WARNING_FLAGS) -c getpid.c

clean:
        rm -rf $(EXE_TIME) $(EXE_PID) *.o