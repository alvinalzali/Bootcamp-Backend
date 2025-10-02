package main

import (
	"context"
	"fmt"
	"grpc/service"
	"log"

	_ "github.com/lib/pq"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func main() {

	//membuat code koneksi client ke server grpc

	conn, err := grpc.NewClient("150.20.30.105:25265", grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	//membuat client dari service yang sudah di generate
	c := service.NewUserServiceClient(conn)

	// mempersiapkan data untuk akses user service atau request
	req := &service.UserRequest{Id: 1}

	// req ke server grpc
	res, err := c.GetUserInfo(context.Background(), req)
	if err != nil {
		log.Fatalf("could not get user info: %v", err)
	}
	fmt.Println("User info:", res)

}
