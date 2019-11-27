#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

/*
** Refer to this shell script for Firecracker: https://github.com/firecracker-microvm/firecracker-demo/blob/master/parallel-start-many.sh
** Source reference: https://github.com/EthanGYoung/gvisor_analysis/blob/master/experiments/lifecycle/thread_spinup_throughput/spinup.c
** Sample Execution Command:
** make spinup
** ./driver 1
*/

int NUM_TRIALS;

/* TODO: Take out this method in a helper file.*/
struct timespec diff(struct timespec start, struct timespec end)
{
        struct timespec temp;
        if ((end.tv_nsec - start.tv_nsec) < 0)
        {
                temp.tv_sec = end.tv_sec - start.tv_sec - 1;
                temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
        }
        else
        {
                temp.tv_sec = end.tv_sec - start.tv_sec;
                temp.tv_nsec = end.tv_nsec - start.tv_nsec;
        }
        return temp;
}

int main(int argc, char *argv[]) {
	/* Parse command line args */
	if (argc != 2) {
          printf("ERROR: Usage: ./driver <number of trials>\n");
          return 0;
  }

  NUM_TRIALS = atoi(argv[1]);

  printf("Starting Spinup Throughput Test for %d calls\n", NUM_TRIALS);

  struct timespec ts0;
  clock_gettime(CLOCK_REALTIME, &ts0);

  for (int i = 0; i < NUM_TRIALS; i++) {
          char str[1000];
          // strcpy(str, "firectl --kernel=hello-vmlinux.bin --root-drive=hello-rootfs.ext4");
          strcpy(str, "firectl --kernel=hello-vmlinux.bin  --root-drive=hello-rootfs.ext4 --kernel-opts=\"reboot=k panic=1 pci=off nomodules 8250.nr_uarts=0 i8042.noaux i8042.nomux i8042.nopnp i8042.dumbkbd\"");
          system(str);
  }

  struct timespec ts1;
  clock_gettime(CLOCK_REALTIME, &ts1);
  struct timespec t = diff(ts0, ts1);

  float elapsed_time = t.tv_sec + t.tv_nsec/(float)1000000000;

  printf("LOG_OUTPUT: Average for %d calls:\n", NUM_TRIALS);
  printf("LOG_OUTPUT: Total Spinup time = %.12f seconds\n", elapsed_time);
  printf("LOG_OUTPUT: Spinup throughput Average = %.12f microVMs/sec\n", elapsed_time/NUM_TRIALS);

  return 0;
}
