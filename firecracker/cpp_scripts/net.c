#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

/*
** Source reference: https://github.com/EthanGYoung/gvisor_analysis/blob/master/experiments/execute/network_throughput/net.c
** Sample Execution Command:
** gcc net.c -o net
** ./net 10 "http://90.130.70.73/1MB.zip"
*/

int NUM_TRIALS;
char* URL;

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
	if (argc != 3) {
          printf("ERROR: Usage: ./driver <number of trials> <URL to curl>\n");
          return 0;
  }

  NUM_TRIALS = atoi(argv[1]);
  URL = argv[2];

  float total = 0;
  float trial_val = 0;

  printf("Starting Network Throughput Test\n");

  struct timespec ts0;
  clock_gettime(CLOCK_REALTIME, &ts0);

  for (int i = 0; i < NUM_TRIALS; i++) {
          char str[1000];
          strcpy(str, "curl -so /dev/null ");
          strcat(str, URL);
          system(str);
  }

  struct timespec ts1;
  clock_gettime(CLOCK_REALTIME, &ts1);
  struct timespec t = diff(ts0,ts1);

  float elapsed_time = t.tv_sec + t.tv_nsec/(float)1000000000;

  printf("LOG_OUTPUT: Average for %d calls: network download time average = %.12f seconds\n", NUM_TRIALS, elapsed_time/NUM_TRIALS);


  return 0;
}
