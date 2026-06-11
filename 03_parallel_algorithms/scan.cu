#include <iostream>
#include <cuda_runtime.h>
#include "../common/timer.h"

// Placeholder: exclusive scan per-block sample (for demonstration)
__global__ void scan_block(int *data, int N){
  extern __shared__ int s[];
  int tid = threadIdx.x + blockIdx.x * blockDim.x;
  int lane = threadIdx.x;
  if (tid < N) s[lane] = data[tid]; else s[lane]=0;
  __syncthreads();
  for (int offset=1; offset<blockDim.x; offset<<=1){
    int val = 0;
    if (lane >= offset) val = s[lane - offset];
    __syncthreads();
    s[lane] += val;
    __syncthreads();
  }
  if (tid < N) data[tid] = s[lane];
}

int main(){
  const int N = 1<<16;
  int *d;
  cudaMalloc(&d, N * sizeof(int));
  int threads = 256; int blocks = (N+threads-1)/threads;
  {
    Timer t("scan_block");
    scan_block<<<blocks,threads,threads * sizeof(int)>>>(d,N);
    cudaDeviceSynchronize();
  }
  cudaFree(d);
  std::cout << "scan demo done\n";
}
