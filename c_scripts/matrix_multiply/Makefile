CC = gcc
WARNING_FLAGS = -Wall -Wextra
EXE = matrix

matrix: clean matrix.o
        $(CC) -o $(EXE) matrix.o

matrix.o:
        $(CC) $(WARNING_FLAGS) -c matrix.c

clean:
        rm -rf $(EXE) $(EXE) *.o