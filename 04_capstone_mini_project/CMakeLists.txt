add_executable(convolution convolution.cu)
target_include_directories(convolution PRIVATE ${CMAKE_SOURCE_DIR}/common)
set_target_properties(convolution PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
