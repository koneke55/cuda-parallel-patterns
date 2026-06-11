#include <iostream>
#include <vector>
#include <cuda_runtime.h>
#include "../common/timer.h"

__global__ void vecAdd(const float* A, const float* B, float* C, int N) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i < N) C[i] = A[i] + B[i];
}

int main(){
  const int N = 1<<20;
  size_t bytes = N * sizeof(float);
  std::vector<float> hA(N, 1.0f), hB(N, 2.0f), hC(N, 0.0f);

  float *dA, *dB, *dC;
  cudaMalloc(&dA, bytes);
  cudaMalloc(&dB, bytes);
  cudaMalloc(&dC, bytes);

  cudaMemcpy(dA, hA.data(), bytes, cudaMemcpyHostToDevice);
  cudaMemcpy(dB, hB.data(), bytes, cudaMemcpyHostToDevice);

  int threads = 256;
  int blocks = (N + threads - 1) / threads;
  {
    Timer t("vecAdd");
    vecAdd<<<blocks, threads>>>(dA, dB, dC, N);
    cudaDeviceSynchronize();
  }

  cudaMemcpy(hC.data(), dC, bytes, cudaMemcpyDeviceToHost);

  // verify
  for (int i=0;i<10;i++) std::cout << hC[i] << " ";
  std::cout << "\n";

  cudaFree(dA); cudaFree(dB); cudaFree(dC);
  return 0;
}
