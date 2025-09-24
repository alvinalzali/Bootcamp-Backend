package main

import (
	"fmt"
	"sync"
)

// Struct untuk mengirim hasil + index lewat channel
type result struct {
	index int
	value int
}

// Worker: kalikan angka dengan 2
func worker(index, angka int, out chan<- result, wg *sync.WaitGroup) {
	defer wg.Done()
	out <- result{index: index, value: angka * 2}
}

func main() {
	// Angka awal
	angkaBanyak := []int{2, 3, 5, 7, 9}
	fmt.Println("Angka awal:", angkaBanyak)

	// Channel untuk fan-in
	out := make(chan result, len(angkaBanyak))
	var wg sync.WaitGroup

	// Fan-out: setiap angka diproses goroutine terpisah
	for i, angka := range angkaBanyak {
		wg.Add(1)
		go worker(i, angka, out, &wg)
	}

	// Tutup channel setelah semua worker selesai
	go func() {
		wg.Wait()
		close(out)
	}()

	// Fan-in: kumpulin data dari setiap channel ke slice hasil
	hasil := make([]int, len(angkaBanyak))
	for res := range out {
		hasil[res.index] = res.value
	}

	fmt.Println("Hasil proses:", hasil)
}
