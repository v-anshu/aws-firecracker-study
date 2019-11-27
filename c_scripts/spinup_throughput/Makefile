CC = gcc
WARNING_FLAGS = -Wall -Wextra
EXE = driver

clean:
	rm -f $(EXE) *.o

spinup: clean driver.o
	$(CC) -o $(EXE) driver.ov

driver.o: driver.c
	$(CC) $(WARNING_FLAGS) -c driver.c
