CC = gcc
EXE = openclose

openclose: clean openclose.o
	$(CC) -o $(EXE) openclose.o
openclose.o: openclose.c
	$(CC) -c openclose.c
clean:
	rm -f $(EXE) *.o
