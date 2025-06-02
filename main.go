package main

import (
	"fmt"
	"log"
	"time"

	"github.com/anfredette/go-dcgm/pkg/dcgm"
)

func main() {
	// Initialize DCGM
	_, err := dcgm.Init(dcgm.Embedded)
	if err != nil {
		log.Fatalf("Failed to initialize DCGM: %v", err)
	}
	defer dcgm.Shutdown()

	// Get all GPU devices
	gpus, err := dcgm.GetSupportedDevices()
	if err != nil {
		log.Fatalf("Failed to get GPU devices: %v", err)
	}

	if len(gpus) == 0 {
		log.Fatal("No GPUs found")
	}

	fmt.Println("Discovered GPUs:")
	// Print basic info about each GPU
	for _, gpu := range gpus {
		info, err := dcgm.GetDeviceInfo(gpu)
		if err != nil {
			log.Printf("Failed to get info for GPU %d: %v", gpu, err)
			continue
		}
		fmt.Printf("GPU %d: %d (UUID: %s)\n", gpu, info.GPU, info.UUID)
	}

	// Monitor GPU metrics every 5 seconds
	ticker := time.NewTicker(5 * time.Second)
	defer ticker.Stop()

	for range ticker.C {
		fmt.Println("\nGPU Metrics:")
		for _, gpu := range gpus {
			status, err := dcgm.GetDeviceStatus(gpu)
			if err != nil {
				log.Printf("Failed to get status for GPU %d: %v", gpu, err)
				continue
			}

			fmt.Printf("GPU %d:\n", gpu)
			fmt.Printf("  GPU Utilization: %d%%\n", status.Utilization.GPU)
			fmt.Printf("  Memory Used: %.2f GB\n",
				float64(status.Memory.GlobalUsed)/1024.0/1024.0/1024.0)
			fmt.Printf("  Memory Utilization: %d%%\n", status.Utilization.Memory)
			fmt.Printf("  Temperature: %d°C\n", status.Temperature)
			fmt.Printf("  Power Usage: %.2f W\n", status.Power)
		}
	}
}
