package main

import "fmt"

func main() {
	var nama string = "Alvin"
	umur := 25

	fmt.Println("Nama Saya : ", nama)
	fmt.Println("Umur Saya : ", umur)

	//array
	var angka [3]int = [3]int{1, 2, 3}
	fmt.Println("Angka : ", angka)
	fmt.Println("Panjang array : ", len(angka))
	fmt.Println("Isi index ke 1 : ", angka[1])

	//slice
	buah := []string{"apel", "mangga", "jeruk"}
	fmt.Println("Buah : ", buah)
	fmt.Println("Panjang slice : ", len(buah))
	fmt.Println("Isi index ke 2 : ", buah[2])

	//map
	nilai := map[string]int{
		"math":    90,
		"english": 85,
	}
	fmt.Println("Map Nilai : ", nilai)
	fmt.Println("Nilai Math : ", nilai["math"])
	fmt.Println("Nilai English : ", nilai["english"])

	//struct
	type person struct {
		name   string
		age    int
		height float64
	}
	person1 := person{"Alvin", 25, 163.5}
	fmt.Println("Person 1 : ", person1)
	fmt.Println("Person 1 Name : ", person1.name)
	fmt.Println("Person 1 Age : ", person1.age)

	//pointer
	var a int = 10
	var b *int = &a
	fmt.Println("Nilai a : ", a)
	fmt.Println("Nilai b : ", b)
	fmt.Println("Nilai a dengan pointer : ", *b)

	//interface
	var i interface{} = 10
	fmt.Println("Nilai i : ", i)
	fmt.Println("Nilai i dengan type : ", i.(int))

	//type conversion
	var c int = 20
	var d float64 = float64(c)
	fmt.Println("Nilai c : ", c)
	fmt.Println("Nilai d : ", d)

	//type assertion
	var e interface{} = "Alvin"
	var f string = e.(string)
	fmt.Println("Nilai e : ", e)
	fmt.Println("Nilai f : ", f)

	//type switch
	var g interface{} = "Alvin"
	switch g.(type) {
	case int:
		fmt.Println("Nilai g adalah integer")
	case string:
		fmt.Println("Nilai g adalah string")
	default:
		fmt.Println("Nilai g tidak diketahui")
	}

	//type switch
	var h interface{} = "Alvin"
	switch h.(type) {
	case int:
		fmt.Println("Nilai h adalah integer")
	case string:
		fmt.Println("Nilai h adalah string")
	default:
		fmt.Println("Nilai h tidak diketahui")
	}

}
