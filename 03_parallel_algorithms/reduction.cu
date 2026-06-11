#include <iostream>
#include <cuda_runtime.h>
#include "../common/timer.h"

__global__ void reduce_kernel(const float* in, float* out, int N){
  extern __shared__ float sdata[];
  int tid = threadIdx.x;
  int i = blockIdx.x * (blockDim.x * 2) + tid;
  float sum = 0;
  if (i < N) sum = in[i];
  if (i + blockDim.x < N) sum += in[i + blockDim.x];
  sdata[tid] = sum;
  __syncthreads();
  for (unsigned int s = blockDim.x/2; s>0; s>>=1){
    if (tid < s) sdata[tid] += sdata[tid + s];
    __syncthreads();
  }
  if (tid == 0) out[blockIdx.x] = sdata[0];
}

int main(){
  const int N = 1<<20;
  size_t bytes = N * sizeof(float);
  float *dIn, *dOut;
  cudaMalloc(&dIn, bytes);
  int blocks = 128; int threads = 256;
  cudaMalloc(&dOut, blocks * sizeof(float));
  {
    Timer t("reduction");
    reduce_kernel<<<blocks, threads, threads * sizeof(float)>>>(dIn, dOut, N);
    cudaDeviceSynchronize();
  }
  cudaFree(dIn); cudaFree(dOut);
  std::cout << "reduction demo done\n";
}
