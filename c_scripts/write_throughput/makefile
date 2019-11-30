CC = gcc
EXE = write

write: clean write.o
	$(CC) -o $(EXE) write.o
write.o: write.c
	$(CC) -c write.c
clean:
	rm -f $(EXE) *.o
