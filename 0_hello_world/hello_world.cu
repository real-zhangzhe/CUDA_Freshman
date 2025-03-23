#include <cuda_runtime_api.h>
#include <stdio.h>

// cuda 中 host 表示 cpu 端，device 表示 gpu 端
// __device__ 是设备函数的声明符号，表明该函数在 device 执行，且只能在 device
// 中调用
__device__ const char *device_hello_world(void) {
  return "GPU: Hello world!\n";
}

// __host__ 是主机函数的声明符号，表明该函数在 host 执行，且只能在 host 中调用
__host__ const char *host_hello_world(void) { return "CPU: Hello world!\n"; }

// __global__ 是核函数的声明符号，表明该函数在 device 执行，且只能在 host 中调用
__global__ void hello_world(void) {
  const char *str = device_hello_world();
  printf("%s", str);
}

int main(int argc, char **argv) {
  printf("%s", host_hello_world());
  // <<<grid_dim, block_dim>>> 是核函数的调用符号，表示启动 grid_dim 个 block，
  // 每个 block 有 block_dim 个线程
  hello_world<<<1, 10>>>();
  cudaDeviceReset();
  return 0;
}
