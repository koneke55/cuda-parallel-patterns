#include <iostream>
#include <cuda_runtime.h>
#include "../common/timer.h"

__global__ void coalesced_load(const float* data, float* out, int N) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i < N) out[i] = data[i];
}

int main(){
  const int N = 1<<20;
  size_t bytes = N * sizeof(float);
  float *dData, *dOut;
  cudaMalloc(&dData, bytes);
  cudaMalloc(&dOut, bytes);
  cudaMemset(dData, 0, bytes);

  int t = 256; int b = (N + t -1)/t;
  {
    Timer T("coalesced_load");
    coalesced_load<<<b,t>>>(dData,dOut,N);
    cudaDeviceSynchronize();
  }

  cudaFree(dData); cudaFree(dOut);
  std::cout << "coalescing done\n";
}
