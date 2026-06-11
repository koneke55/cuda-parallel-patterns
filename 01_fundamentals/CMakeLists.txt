add_executable(vector_add vector_add.cu)
target_include_directories(vector_add PRIVATE ${CMAKE_SOURCE_DIR}/common)
set_target_properties(vector_add PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

add_executable(matrix_mul matrix_mul.cu)
target_include_directories(matrix_mul PRIVATE ${CMAKE_SOURCE_DIR}/common)
set_target_properties(matrix_mul PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
