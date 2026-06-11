#include <iostream>
#include <vector>
#include <cuda_runtime.h>
#include "../common/timer.h"

// Very small 3x3 convolution demo on a synthetic image
__global__ void conv3x3(const float* in, float* out, int W, int H, const float* kernel){
  int x = blockIdx.x * blockDim.x + threadIdx.x;
  int y = blockIdx.y * blockDim.y + threadIdx.y;
  if (x>=W || y>=H) return;
  float sum=0.0f;
  for (int ky=-1; ky<=1; ++ky) for (int kx=-1;kx<=1;++kx){
    int ix = min(max(x+kx,0), W-1);
    int iy = min(max(y+ky,0), H-1);
    sum += in[iy*W + ix] * kernel[(ky+1)*3 + (kx+1)];
  }
  out[y*W + x] = sum;
}

int main(){
  const int W = 512, H = 512;
  int N = W*H;
  std::vector<float> img(N, 1.0f), out(N,0.0f);
  float host_kernel[9] = {1/9.f,1/9.f,1/9.f,1/9.f,1/9.f,1/9.f,1/9.f,1/9.f,1/9.f};

  float *dIn, *dOut, *dK;
  cudaMalloc(&dIn, N*sizeof(float)); cudaMalloc(&dOut, N*sizeof(float)); cudaMalloc(&dK, 9*sizeof(float));
  cudaMemcpy(dIn, img.data(), N*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(dK, host_kernel, 9*sizeof(float), cudaMemcpyHostToDevice);

  dim3 t(16,16); dim3 b((W+t.x-1)/t.x,(H+t.y-1)/t.y);
  {
    Timer T("conv3x3");
    conv3x3<<<b,t>>>(dIn,dOut,W,H,dK);
    cudaDeviceSynchronize();
  }

  cudaMemcpy(out.data(), dOut, N*sizeof(float), cudaMemcpyDeviceToHost);
  cudaFree(dIn); cudaFree(dOut); cudaFree(dK);
  std::cout << "convolution done sample: " << out[0] << "\n";
  return 0;
}
