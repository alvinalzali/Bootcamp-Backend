# 🚀 Code Backend Golang (Sinau Koding) - Tugas

### Pertemuan 15: Implementasi JWT dan Grouped Routes 

Melanjutkan dari pertemuan sebelumnya, kita menambahkan fitur:

- Login user dengan hardcoded credential
- Generate JWT Token menggunakan `github.com/golang-jwt/jwt/v5`
- Middleware untuk validasi token JWT
- Protected routes (`/users`) yang hanya bisa diakses jika user memiliki token valid

---

### Pertemuan 13-14: Membuat API dan Connect ke Database PostgreSQL

Membuat **RESTful API** dengan bahasa **Go (Golang)** menggunakan framework **Echo**, connect database **PostgreSQL**. 
Hal yang dapat dilakukan :

- Membuat endpoint CRUD (Create, Read, Update, Delete) untuk data `User`
- Validasi data dengan `go-playground/validator`
- Dokumentasi API menggunakan Swagger (`swaggo/echo-swagger`)
- Load konfigurasi dari file `.env`
- Menggunakan `database/sql` untuk koneksi database

---

## 📦 Libraries Golang (Ver)

Berikut adalah beberapa library utama yang digunakan:

| Library | Fungsi | Versi (minimal) |
|--------|--------|----------------|
| [`echo`](https://github.com/labstack/echo) | Web framework | v4 |
| [`jwt/v5`](https://github.com/golang-jwt/jwt) | JSON Web Token | v5 |
| [`pq`](https://github.com/lib/pq) | PostgreSQL Driver | latest |
| [`godotenv`](https://github.com/joho/godotenv) | Load .env files | latest |
| [`validator`](https://github.com/go-playground/validator) | Validasi struct | v10 |
| [`swaggo/echo-swagger`](https://github.com/swaggo/echo-swagger) | Swagger Docs | latest |

---

## ⚙️ Struktur Proyek

```plaintext
.
├── main.go                 # Entry point utama aplikasi (routing, init, server)
├── middleware/
│   └── jwt_middleware.go   # Middleware untuk validasi JWT token
├── docs/                   # Dokumentasi Swagger (hasil generate `swag init`)
│   └── ...                 # Auto-generated files oleh Swag
├── .env                    # Konfigurasi environment (db config, jwt secret, dll)
├── go.mod                  # Modul dependency Go
├── go.sum                  # Checksum dan versi dependency
└── README.md               # Dokumentasi project (file ini)
```
