% cuda-parallel-patterns

An implementation portfolio of core CUDA parallel algorithms, memory optimizations, and performance profiles inspired by Shane Cook's "CUDA Programming".

Overview
- Purpose: learn and demonstrate CUDA patterns with runnable examples and performance notes.
- Layout:
  - `common/` - shared helpers (timers, error checks)
  - `01_fundamentals/` - Vector Add, Matrix Multiply
  - `02_memory_patterns/` - Coalescing, Shared Memory, Constant Memory (examples)
  - `03_parallel_algorithms/` - Reduction, Scan, Bitonic Sort
  - `04_capstone_mini_project/` - Image convolution example
  - `docs/` - performance notes and graphs

Quickstart
Prerequisites: CUDA toolkit, CMake >= 3.18, a CUDA-capable GPU.

Build and run examples:
```bash
cd Embedded Programming/Cuda/cuda-parallel-patterns
./build.sh
# run a sample executable
./build/01_fundamentals/vector_add
```

Create & push a GitHub repo (helper script):
```bash
cd Embedded Programming/Cuda/cuda-parallel-patterns
./scripts/create_remote_repo.sh --name cuda-parallel-patterns --public
```

See `docs/README.md` for profile guidelines.
