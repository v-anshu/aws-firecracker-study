#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <stdint.h>

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

float **mat_init(int n_rows, int n_cols)
{
    float **m;
    int i;
    m = (float**)malloc(n_rows * sizeof(float*));
    m[0] = (float*)calloc(n_rows * n_cols, sizeof(float));
    for (i = 1; i < n_rows; ++i)
        m[i] = m[i-1] + n_cols;
    return m;
}

void mat_destroy(float **m)
{
    free(m[0]); free(m);
}

static inline uint64_t xorshift128plus(uint64_t s[2])
{
    uint64_t x, y;
    x = s[0], y = s[1];
    s[0] = y;
    x ^= x << 23;
    s[1] = x ^ y ^ (x >> 17) ^ (y >> 26);
    y += s[1];
    return y;
}

static uint64_t mat_rng[2] = { 11ULL, 1181783497276652981ULL };

double mat_drand(void)
{
    return (xorshift128plus(mat_rng)>>11) * (1.0/9007199254740992.0);
}

float **mat_gen_random(int n_rows, int n_cols)
{
    float **m;
    int i, j;
    m = mat_init(n_rows, n_cols);
    for (i = 0; i < n_rows; ++i)
        for (j = 0; j < n_cols; ++j)
            m[i][j] = mat_drand();
    return m;
}

float mat_mul(int n_a_rows, int n_a_cols, float *const *a, int n_b_cols, float *const *b)
{
    int i, j, k;
    float **m;
    m = mat_init(n_a_rows, n_b_cols);

    
    struct timespec ts0;
    clock_gettime(CLOCK_REALTIME, &ts0);


    for (i = 0; i < n_a_rows; ++i) {
        for (j = 0; j < n_b_cols; ++j) {
            float t = 0.0;
            for (k = 0; k < n_a_cols; ++k)
                t += a[i][k] * b[k][j];
            m[i][j] = t;
        }
    }


    struct timespec ts1;
    clock_gettime(CLOCK_REALTIME, &ts1);
    struct timespec t = diff(ts0,ts1);

    float elapsed_time = t.tv_sec + t.tv_nsec/(float)1000000000;

    if (m) mat_destroy(m);
    return elapsed_time;;
}

int main(int argc, char *argv[]) {

    if (argc != 3) {
        printf("ERROR: Usage: ./matrix <number of rows/columns> <number of calls>\n");
        return 0;
    }

    int n = atoi(argv[1]);
    int NUM_CALLS = atoi(argv[2]);

    float **a, **b, **m = 0;
    float total = 0.0;

    a = mat_gen_random(n, n);
    b = mat_gen_random(n, n);

    for (int i = 0; i < NUM_CALLS; i++) {
        total += mat_mul(n, n, a, n, b);
    }

    printf("LOG_OUTPUT: Average time taken for %dx%d matrix multiplication for %d trials = %.3f milliseconds\n",
            n, n, NUM_CALLS, 1000*(total/NUM_CALLS));

    mat_destroy(b); mat_destroy(a);
    return 0;
}
