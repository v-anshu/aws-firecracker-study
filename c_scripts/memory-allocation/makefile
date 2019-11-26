CC = gcc
FREE_EXE = malloc_free
EXE = malloc_without_free

malloc_free: clean malloc_free.o
	$(CC) -o $(FREE_EXE) malloc_free.o
malloc_without_free: clean malloc_without_free.o
	$(CC) -o $(EXE) malloc_without_free.o
malloc_free.o: malloc_free.c
	$(CC) -c malloc_free.c
malloc_without_free.o: malloc_without_free.c
	$(CC) -c malloc_without_free.c
clean:
	rm -f $(EXE) *.o
	rm -f $(FREE_EXE) *.o