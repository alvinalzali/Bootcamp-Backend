package main

import (
	"context"
	"database/sql"
	"fmt"
	"grpc/service"
	"log"
	"net"

	_ "github.com/lib/pq"

	"google.golang.org/grpc"
)

// connect ke db postgreSQL

type server struct {
	// Add server fields here
	service.UnimplementedUserServiceServer
	db *sql.DB
}

type user struct {
	ID   int
	Name string
	Age  int
}

func (s *server) GetUserInfo(ctx context.Context, req *service.UserRequest) (*service.UserResponse,
	error) {
	// Implement your logic here
	// Proses untuk mendapatkan data user
	// user := &service.UserResponse{
	// 	Id:   req.Id,
	// 	Name: "John Doe",
	// 	Age:  30,
	// }

	// ambil data user dari request
	id := req.Id

	// query data dari request dengan id yang di dapat dan bind ke struct user
	var u user
	err := s.db.QueryRow("SELECT id, name, age FROM users WHERE id = $1", id).Scan(&u.ID, &u.Name, &u.Age)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("user with ID %d not found", id)
		}
		return nil, fmt.Errorf("failed to get user: %v", err)
	}

	// simpan data user
	user := &service.UserResponse{
		Id:   int32(u.ID),
		Name: u.Name,
		Age:  int32(u.Age),
	}

	// simpan context dan user ke return

	return user, nil

	// // Simulasi pengambilan data user dari database
	// user := &service.UserResponse{}
	// row := s.db.QueryRow("SELECT id, name, age FROM users WHERE id = $1", req.Id)
	// err := row.Scan(&user.Id, &user.Name, &user.Age)

	// //cek error dan bind ke struct user
	// if err != nil {
	// 	if err == sql.ErrNoRows {
	// 		return nil, fmt.Errorf("user with ID %d not found", req.Id)
	// 	}
	// 	return nil, fmt.Errorf("failed to get user: %v", err)
	// }

	// // Kembalikan data user
	// return user, nil
}

// func (s *server) GetUserInfo(c echo.Context, req *service.UserRequest) (*service.UserResponse, error) {

// 	// Implement your logic here
// 	// Proses untuk mendapatkan data user
// 	// user := &service.UserResponse{
// 	// 	Id:   req.Id,
// 	// 	Name: "John Doe",
// 	// 	Age:  30,
// 	// }

// 	// // ambil data user dari request
// 	// id := req.Id

// 	// // query data dari request dengan id yang di dapat dan bind ke struct user
// 	// var u User
// 	// err := s.db.QueryRow("SELECT id, name, age FROM users WHERE id = $1", id).Scan(&u.ID, &u.Name, &u.Age)
// 	// if err != nil {
// 	// 	if err == sql.ErrNoRows {
// 	// 		return c.JSON(http.StatusNotFound, echo.Map{
// 	// 			"error": fmt.Sprintf("User with ID %d not found", id),
// 	// 		})
// 	// 	}
// 	// 	return c.JSON(http.StatusInternalServerError, echo.Map{
// 	// 		"error": err.Error(),
// 	// 	})
// 	// }
// 	// // simpan context dan user ke return

// 	// return c.JSON(http.StatusNotFound, echo.Map{
// 	// 	"id":   u.ID,
// 	// 	"name": u.Name,
// 	// 	"age":  u.Age,
// 	// })

// 	// Simulasi pengambilan data user dari database
// 	user := &service.UserResponse{}
// 	row := s.db.QueryRow("SELECT id, name, age FROM users WHERE id = $1", req.Id)
// 	err := row.Scan(&user.Id, &user.Name, &user.Age)

// 	//cek error dan bind ke struct user
// 	if err != nil {
// 		if err == sql.ErrNoRows {
// 			return nil, fmt.Errorf("user with ID %d not found", req.Id)
// 		}
// 		return nil, fmt.Errorf("failed to get user: %v", err)
// 	}

// 	// Kembalikan data user
// 	return user, nil
// }

func main() {

	// membuat connect ke db postgreSQL
	db, err := sql.Open("postgres", "host=localhost port=5432 user=postgres password=Alvin40 dbname=sinau_v2 sslmode=disable")
	if err != nil {
		log.Fatalf("failed to connect to database: %v", err)
	}
	// defer db.Close()

	// cek koneksi db
	err = db.Ping()
	if err != nil {
		log.Fatalf("failed to ping database: %v", err)
	}
	fmt.Println("Connected to the database successfully")

	lis, err := net.Listen("tcp", ":25265") //custom port grpc
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()
	service.RegisterUserServiceServer(s, &server{db: db})
	fmt.Println("gRPC server listening on port 25265")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
