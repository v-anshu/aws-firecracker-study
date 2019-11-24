#include <iostream>
#include <cstdlib>
#include <chrono>
using namespace std::chrono;
using namespace std;

// Command line argument, enter malloc size in KB, iteration count
// Install C++ compiler on alpine
int main(int argc, char** argv) {

    if(argc != 2){
        cout<<"Correct argument: Malloc size in KB";
        exit(1);
    }

    int *ptr;
    int iteration_count = 100000;
    int size_in_kb = atoi(argv[1]);
    auto start = high_resolution_clock::now();
    for(int i = 0; i < iteration_count; i++){
        ptr = (int*) malloc(size_in_kb * 1000 * sizeof(char));
        if(!ptr)
        {
            cout << "Memory Allocation Failed";
            exit(1);
        }
    }

    auto stop = high_resolution_clock::now();
    auto duration = (duration_cast<microseconds>(stop - start))/iteration_count;

    cout << "Time taken by function for single allocation count: "
         << duration.count() << " microseconds" << endl;
    return 0;
}