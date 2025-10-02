package main

import (
	"context"
	"fmt"
	"grpc/service"
	"log"
	"net"

	"google.golang.org/grpc"
)

type server struct {
	// Add server fields here
	service.UnimplementedUserServiceServer
}

func (s *server) GetUserInfo(ctx context.Context, req *service.UserRequest) (*service.UserResponse,
	error) {
	// Implement your logic here
	// Proses untuk mendapatkan data user
	user := &service.UserResponse{
		Id:   req.Id,
		Name: "John Doe",
		Age:  30,
	}
	return user, nil
}

func main() {
	lis, err := net.Listen("tcp", ":25265") //custom port grpc
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()
	service.RegisterUserServiceServer(s, &server{})
	fmt.Println("gRPC server listening on port 25265")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
