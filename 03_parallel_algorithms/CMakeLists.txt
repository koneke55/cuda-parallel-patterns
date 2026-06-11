add_executable(reduction reduction.cu)
target_include_directories(reduction PRIVATE ${CMAKE_SOURCE_DIR}/common)
set_target_properties(reduction PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

add_executable(scan scan.cu)
target_include_directories(scan PRIVATE ${CMAKE_SOURCE_DIR}/common)
set_target_properties(scan PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

add_executable(bitonic_sort bitonic_sort.cu)
target_include_directories(bitonic_sort PRIVATE ${CMAKE_SOURCE_DIR}/common)
set_target_properties(bitonic_sort PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
