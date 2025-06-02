# NVIDIA GPU Monitor

A simple Go program that monitors NVIDIA GPUs using the DCGM (Data Center GPU Manager) library.

## Prerequisites

- NVIDIA GPU(s)
- NVIDIA drivers installed
- DCGM installed (https://github.com/NVIDIA/DCGM)
- Go 1.16 or later

## Installation

1. Clone this repository:
```bash
git clone https://github.com/anfredette/dcgm-test
cd dcgm-test
```

2. Install dependencies:
```bash
go mod tidy
```

## Usage

Run the program using

```bash
go run main.go
```

or

```bash
go build
./dcgm-test
```

The program will:
1. Discover all NVIDIA GPUs on the system
2. Print basic information about each GPU
3. Display a set of metrics for each GPU every 5 seconds.

Sample Output:

```bash
Discovered GPUs:
GPU 0: 0 (UUID: GPU-cd88a02f-50e4-a280-3ec3-9863cecb25ac)
GPU 1: 1 (UUID: GPU-96731460-6dc2-5dd6-5034-703dbd711eeb)
GPU 2: 2 (UUID: GPU-954bc868-b6a1-bf55-13a4-46ccf51dd045)
GPU 3: 3 (UUID: GPU-8c49e76e-58b8-11c2-fa33-49569da6c622)

GPU Metrics:
GPU 0:
  GPU Utilization: 0%
  Memory Used: 0.00 B
  Memory Utilization: 0%
  Temperature: 42°C
  Power Usage: 83.05 W
GPU 1:
  GPU Utilization: 0%
  Memory Used: 0.00 B
  Memory Utilization: 0%
  Temperature: 29°C
  Power Usage: 23.36 W
GPU 2:
  GPU Utilization: 0%
  Memory Used: 0.00 B
  Memory Utilization: 0%
  Temperature: 28°C
  Power Usage: 22.51 W
GPU 3:
  GPU Utilization: 0%
  Memory Used: 0.00 B
  Memory Utilization: 0%
  Temperature: 42°C
  Power Usage: 84.53 W
```

## Note

This code is currently using a fork of https://github.com/NVIDIA/go-dcgm with
https://github.com/NVIDIA/go-dcgm/pull/81 applied becuase the versions of DCGM
that were installed on some recent Linxu distributions I tried came with v3 of
libdcgm, and that didn't work with the most recent version of go-dcgm.