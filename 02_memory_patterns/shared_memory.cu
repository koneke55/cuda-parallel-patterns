#include <iostream>
#include <cuda_runtime.h>
#include "../common/timer.h"

__global__ void saxpy_shared(const float* x, float* y, float a, int N){
  extern __shared__ float s[];
  int tid = threadIdx.x + blockIdx.x * blockDim.x;
  int idx = threadIdx.x;
  if (tid < N) s[idx] = x[tid];
  __syncthreads();
  if (tid < N) y[tid] = a * s[idx] + y[tid];
}

int main(){
  const int N = 1<<18;
  size_t bytes = N * sizeof(float);
  float *dX, *dY;
  cudaMalloc(&dX, bytes); cudaMalloc(&dY, bytes);
  cudaMemset(dX, 1, bytes);
  cudaMemset(dY, 0, bytes);

  int t = 256; int b = (N + t -1)/t;
  {
    Timer T("saxpy_shared");
    saxpy_shared<<<b,t,t * sizeof(float)>>>(dX,dY,2.0f,N);
    cudaDeviceSynchronize();
  }

  cudaFree(dX); cudaFree(dY);
  std::cout << "shared_memory demo done\n";
}
