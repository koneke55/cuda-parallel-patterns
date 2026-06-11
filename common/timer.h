// Simple RAII timer for microbenchmarks
#pragma once
#include <chrono>
#include <string>
#include <iostream>

struct Timer {
  using clock = std::chrono::high_resolution_clock;
  clock::time_point start;
  std::string name;
  Timer(const std::string &n="time"): start(clock::now()), name(n) {}
  ~Timer(){
    auto end = clock::now();
    double ms = std::chrono::duration<double, std::milli>(end - start).count();
    std::cout << name << ": " << ms << " ms\n";
  }
};
