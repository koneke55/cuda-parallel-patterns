#include <iostream>
#include <cuda_runtime.h>
#include "../common/timer.h"

// Simple naive matrix multiply (square)
__global__ void matMul(const float* A, const float* B, float* C, int N) {
  int row = blockIdx.y * blockDim.y + threadIdx.y;
  int col = blockIdx.x * blockDim.x + threadIdx.x;
  if (row < N && col < N) {
    float sum = 0.0f;
    for (int k=0;k<N;k++) sum += A[row*N + k] * B[k*N + col];
    C[row*N + col] = sum;
  }
}

int main(){
  const int N = 256;
  size_t bytes = N * N * sizeof(float);
  float *dA, *dB, *dC;
  cudaMalloc(&dA, bytes); cudaMalloc(&dB, bytes); cudaMalloc(&dC, bytes);

  // initialize on host and copy - skipped for brevity
  // For demo, use device memset 0 and simple kernels in real work
  cudaMemset(dA, 0, bytes); cudaMemset(dB, 0, bytes);

  dim3 threads(16,16);
  dim3 blocks((N+threads.x-1)/threads.x, (N+threads.y-1)/threads.y);
  {
    Timer t("matMul naive");
    matMul<<<blocks, threads>>>(dA, dB, dC, N);
    cudaDeviceSynchronize();
  }

  cudaFree(dA); cudaFree(dB); cudaFree(dC);
  std::cout << "matrix_mul done\n";
  return 0;
}
