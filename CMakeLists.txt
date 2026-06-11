cmake_minimum_required(VERSION 3.18)
project(cuda-parallel-patterns LANGUAGES C CXX CUDA)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 14)

add_subdirectory(01_fundamentals)
add_subdirectory(02_memory_patterns)
add_subdirectory(03_parallel_algorithms)
add_subdirectory(04_capstone_mini_project)
