CC = gcc
WARNING_FLAGS = -Wall -Wextra
EXE = read

read: clean read.o
        $(CC) -o $(EXE) read.o

read.o:
        $(CC) $(WARNING_FLAGS) -c read.c

clean:
        rm -rf $(EXE) *.o