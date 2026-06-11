#include <iostream>
#include <cuda_runtime.h>
#include "../common/timer.h"

// Bitonic sort sample - placeholder: full implementation is longer; this is a scaffold.
__global__ void bitonic_step(int *data, int j, int k){
  unsigned int i = threadIdx.x + blockIdx.x * blockDim.x;
  unsigned int ixj = i ^ j;
  if (ixj > i) {
    if ((i & k) == 0) {
      if (data[i] > data[ixj]) { int tmp = data[i]; data[i]=data[ixj]; data[ixj]=tmp; }
    } else {
      if (data[i] < data[ixj]) { int tmp = data[i]; data[i]=data[ixj]; data[ixj]=tmp; }
    }
  }
}

int main(){
  const int N = 1<<10;
  int *d;
  cudaMalloc(&d, N * sizeof(int));
  int threads = 256; int blocks = (N+threads-1)/threads;
  {
    Timer t("bitonic_sort placeholder");
    // Placeholder run
    bitonic_step<<<blocks,threads>>>(d,1,2);
    cudaDeviceSynchronize();
  }
  cudaFree(d);
  std::cout << "bitonic placeholder done\n";
}
