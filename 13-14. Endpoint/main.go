package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"

	_ "go-echo/docs"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"

	"github.com/go-playground/validator/v10"
	"github.com/labstack/echo/v4"
	echoSwagger "github.com/swaggo/echo-swagger"
)

type CustomValidator struct {
	validator *validator.Validate
}

func (cv *CustomValidator) Validate(i interface{}) error {
	return cv.validator.Struct(i)
}

type User struct {
	ID   int    `json:"id" validate:"required"`
	Name string `json:"name" validate:"required"`
	Age  int    `json:"age" validate:"required,min=0"`
}

var users = []User{
	{ID: 1, Name: "Alice", Age: 30},
	{ID: 2, Name: "Bob", Age: 25},
	{ID: 3, Name: "Charlie", Age: 35},
}

var db *sql.DB

// @title           User API
// @version         1.0
// @description     This is a simple user API server.
// @termsOfService  http://swagger.io/terms/

func main() {
	// read .env file
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	dbHost := os.Getenv("db_host")
	dbPort, _ := strconv.Atoi(os.Getenv("db_port"))
	dbUser := os.Getenv("db_user")
	dbPassword := os.Getenv("db_password")
	dbName := os.Getenv("db_name")

	db = connectDB(dbUser, dbPassword, dbName, dbHost, dbPort)
	e := echo.New()

	e.Validator = &CustomValidator{validator: validator.New()}

	e.GET("/swagger/*", echoSwagger.WrapHandler)

	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Welcome to the User API")
	})
	e.GET("/users", GetUsers)

	// /users/:id
	e.GET("/users/:id", GetUserByID)

	// insert user
	e.POST("/users", CreateUser)

	// update user
	e.PUT("/users/:id", UpdateUser)

	// delete user
	e.DELETE("/users/:id", DeleteUser)

	e.Logger.Fatal(e.Start(":8080"))
}

func connectDB(username, password, dbname, host string, port int) *sql.DB {
	// connect to database
	connSt := "host=" + host + " port=" + strconv.Itoa(port) + " user=" + username + " password=" + password + " dbname=" + dbname + " sslmode=disable"
	db, err := sql.Open("postgres", connSt)
	if err != nil {
		log.Fatal(err)
	}
	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("Connected to database")
	// defer db.Close()

	log.Println("Successfully connected!")
	return db
}

// CreateUser godoc
// @Summary      Create a new user
// @Description  Creates a new user with the provided details
// @Tags         users
// @Accept       json
// @Produce      json
// @Param        user  body      User  true  "User to create"
// @Success      201   {object}  User
// @Failure      400   {object}  map[string]string
// @Router       /users [post]
func CreateUser(c echo.Context) error {
	var newUser User

	if err := c.Bind(&newUser); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": "Invalid input"})
	}

	if err := c.Validate(&newUser); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": err.Error()})
	}

	// Assign a new ID to the user
	// users = append(users, newUser)

	query := `INSERT INTO users (id, name, age) VALUES ($1, $2, $3)`
	_, err := db.Exec(query, newUser.ID, newUser.Name, newUser.Age)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}

	c.Logger().Debug("Creating new user")

	return c.JSON(http.StatusCreated, newUser)
}

// GetUserByID godoc
// @Summary      Get user by ID
// @Description  Retrieves a user by ID
// @Tags         users
// @Produce      json
// @Param        id   path      int  true  "User ID"
// @Success      200  {object}  User
// @Failure      400  {object}  map[string]string
// @Failure      404  {object}  map[string]string
// @Router       /users/{id} [get]
func GetUserByID(c echo.Context) error {
	id := c.Param("id")

	idInt, err := strconv.Atoi(id) // Convert string to int
	if err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": "Invalid user ID"})
	}

	query := `SELECT * FROM users WHERE id = $1`
	row := db.QueryRow(query, idInt)

	var user User
	if err := row.Scan(&user.ID, &user.Name, &user.Age); err != nil {
		if err == sql.ErrNoRows {
			return c.JSON(http.StatusNotFound, echo.Map{"error": "User not found"})
		}
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}

	c.Logger().Debug("Fetching user by ID")
	return c.JSON(http.StatusOK, user)

	// for _, user := range users {
	// 	if user.ID == idInt {
	// 		c.Logger().Debug("Fetching user by ID")
	// 		return c.JSON(http.StatusOK, user)
	// 	}
	// }
}

// GetUsers godoc
// @Summary      Get all users
// @Description  Retrieves a list of all users
// @Tags         users
// @Produce      json
// @Success      200  {array}   User
// @Router       /users [get]
func GetUsers(c echo.Context) error {
	query := `SELECT id, name, age FROM users`
	rows, err := db.Query(query)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}
	defer rows.Close()

	var users []User
	for rows.Next() {
		var user User
		if err := rows.Scan(&user.ID, &user.Name, &user.Age); err != nil {
			return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
		}
		users = append(users, user)
	}

	c.Logger().Debug("Fetching all users")
	return c.JSON(http.StatusOK, users)
}


// UpdateUser godoc
// @Summary      Update an existing user
// @Description  Updates the details of an existing user by ID
// @Tags         users
// @Accept       json
// @Produce      json
// @Param        id    path      int   true  "User ID"
// @Param        user  body      User  true  "Updated user details"
// @Success      200   {object}  User
// @Failure      400   {object}  map[string]string
// @Failure      404   {object}  map[string]string
// @Router       /users/{id} [put]
func UpdateUser(c echo.Context) error {
	id := c.Param("id")
	idInt, err := strconv.Atoi(id)
	if err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": "Invalid user ID"})
	}

	var updatedUser User
	if err := c.Bind(&updatedUser); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": "Invalid input"})
	}

	if err := c.Validate(&updatedUser); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": err.Error()})
	}

	query := `UPDATE users SET name = $1, age = $2 WHERE id = $3`
	res, err := db.Exec(query, updatedUser.Name, updatedUser.Age, idInt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}

	rowsAffected, err := res.RowsAffected()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}
	if rowsAffected == 0 {
		return c.JSON(http.StatusNotFound, echo.Map{"error": "User not found"})
	}

	updatedUser.ID = idInt
	c.Logger().Debug("Updating user")
	return c.JSON(http.StatusOK, updatedUser)
}

// DeleteUser godoc
// @Summary      Delete a user
// @Description  Deletes a user by ID
// @Tags         users
// @Param        id   path      int  true  "User ID"
// @Success      204  "No Content"
// @Failure      400  {object}  map[string]string		
// @Failure      404  {object}  map[string]string
// @Router       /users/{id} [delete]
func DeleteUser(c echo.Context) error {
	id := c.Param("id")
	idInt, err := strconv.Atoi(id)
	if err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": "Invalid user ID"})
	}

	query := `DELETE FROM users WHERE id = $1`
	res, err := db.Exec(query, idInt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}

	rowsAffected, err := res.RowsAffected()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}
	if rowsAffected == 0 {
		return c.JSON(http.StatusNotFound, echo.Map{"error": "User not found"})
	}

	c.Logger().Debug("Deleting user")
	return c.NoContent(http.StatusNoContent)
}
