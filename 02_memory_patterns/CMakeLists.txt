add_executable(coalescing coalescing.cu)
target_include_directories(coalescing PRIVATE ${CMAKE_SOURCE_DIR}/common)
set_target_properties(coalescing PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

add_executable(shared_memory shared_memory.cu)
target_include_directories(shared_memory PRIVATE ${CMAKE_SOURCE_DIR}/common)
set_target_properties(shared_memory PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
