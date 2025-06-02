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

Simply run the program:
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

## Note

This code is currently using a fork of https://github.com/NVIDIA/go-dcgm with
https://github.com/NVIDIA/go-dcgm/pull/81 applied becuase the versions of DCGM
that were installed on some recent Linxu distributions I tried came with v3 of
libdcgm, and that didn't work with the most recent version of go-dcgm.