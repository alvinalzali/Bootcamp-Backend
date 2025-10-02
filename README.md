# 🚀 Backend Golang (Sinau Koding) — Eksplorasi gRPC

## 📚 Pertemuan 16: Microservices Architecture — gRPC (Google Remote Procedure Call)

> Eksplorasi penerapan arsitektur microservices menggunakan **gRPC**, bukan tugas resmi.

### 🔧 Fitur gRPC yang Dieksplorasi:
- Menjalankan procedure di server lain seolah-olah seperti memanggil fungsi lokal
- Transfer data yang sangat cepat dengan format **Protobuf**
- Otomatis generate `struct`, client, dan server handler dari file `.proto`

### 📌 Apa Itu gRPC?
gRPC (Google Remote Procedure Call) adalah framework RPC yang menggunakan HTTP/2 dan Protobuf, memungkinkan komunikasi antar layanan yang:
- **Cepat dan efisien** (dibanding REST/JSON)
- **Type-safe**
- **Lintas bahasa** (Go, Java, Python, dsb)

### ✅ Kapan Menggunakan gRPC?
- Microservices internal antar backend service
- Aplikasi real-time (streaming)
- Performa tinggi dan bandwidth hemat
- Integrasi lintas bahasa (Go ↔ Python, Go ↔ Java, dll)

### ⚠️ Kapan Tidak Disarankan?
- API publik untuk browser atau mobile
- Ingin debugging mudah pakai `curl` atau Postman
- Proyek masih kecil dan belum butuh optimasi performa

---

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
├── main.go                  # Entry point utama (init Echo, routes)
├── middleware/
│   └── jwt.go              # Middleware untuk JWT validation
├── grpc/                   # Service gRPC atau business logic
│   └── proto/              # File .proto untuk gRPC
│   └── client/             # File server gRPC
│   └── server/             # File client gRPC
│   └── service/            # File grpc dan pb (gen-go)
├── docs/                   # Auto-generated Swagger docs
├── .env                    # Konfigurasi environment (DB, JWT secret, dll)
├── go.mod                  # Modul dependency Go
├── go.sum                  # Checksum & lock file untuk dependencies
└── README.md               # Dokumentasi (file ini)

```

## 🚀 Deploy Aplikasi

1. **Build binary:**
   - Untuk **Windows**:
     ```bash
     go build -o <nama_app>.exe
     ```
   - Untuk **Linux** (cross-compiling dari Windows/macOS):
     ```bash
     GOOS=linux GOARCH=amd64 go build -o <nama_app>
     ```

2. **Pindahkan binary** (`.exe` atau tanpa ekstensi, tergantung OS) ke server target.

3. **Jalankan binary di server:**
   - Di Windows:
     ```bash
     .\<nama_app>.exe
     ```
   - Di Linux/macOS:
     ```bash
     ./<nama_app>
     ```

> 💡 Jika sedang build di OS yang sama dengan pembuatan code server golang, cukup jalankan:
```bash
go build .
```

