package middleware

import (
	"fmt"
	"net/http"

	"github.com/golang-jwt/jwt/v5"
	"github.com/labstack/echo/v4"
)

var JwtSecret = []byte("secret")

// membuat fungsi middleware untuk login
func AuthMiddleware(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {
		// ambil token dari header
		tokenString := c.Request().Header.Get("Authorization")
		// cek apakah token ada
		if tokenString == "" {
			return c.JSON(http.StatusUnauthorized, echo.Map{"error": "Missing or invalid token"})
		}

		// validasi token
		parsedToken, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
			return JwtSecret, nil
		})
		if err != nil {
			return c.JSON(http.StatusUnauthorized, echo.Map{"error": "Invalid token"})
		}

		// cek apakah token valid
		if !parsedToken.Valid {
			return c.JSON(http.StatusUnauthorized, echo.Map{"error": "Invalid token"})
		}

		// Ekstrak klaim dari token
		claims, ok := parsedToken.Claims.(jwt.MapClaims)
		if !ok {
			return c.JSON(http.StatusUnauthorized, echo.Map{"error": "Invalid token claims"})
		}

		fmt.Println("User Claims:", claims)

		// jika token valid, lanjut ke handler berikutnya

		return next(c)

	}

}
