CC = gcc
EXE = open_close

open_close: clean open_close.o
	$(CC) -o $(EXE) open_close.o
open_close.o: open_close.c
	$(CC) -c open_close.c
clean:
	rm -f $(EXE) *.o
