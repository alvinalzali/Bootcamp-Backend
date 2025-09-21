# 📌 E-Meeting Database (Tugas Pertemuan 11)

Repository ini berisi **ERD (Entity Relationship Diagram)** dan **file .sql** untuk sistem **E-Meeting**.  

- **ERD Database**: [Lihat di dbdiagram.io](https://dbdiagram.io/d/E-meeting-Alvin-68cd8e8d960f6d821af7296d)  
- **File SQL**: Sudah ada di repo ini

---

## 📖 Deskripsi Database

Database **E-Meeting** fitur:  
- Manajemen pengguna (user & admin)  
- Manajemen meeting room  
- Peserta meeting  
- Paket berlangganan premium  
- Penyimpanan rekaman meeting di cloud  

---

## 🗂 Struktur Tabel

### 1. `users`
| Kolom       | Tipe Data       | Keterangan |
|-------------|----------------|------------|
| id          | int (PK, AI)   | Primary Key, Auto Increment |
| email       | varchar(100)   | Tidak boleh null, unik |
| password    | varchar(255)   | Tidak boleh null |
| name        | varchar(100)   | Nama pengguna |
| role        | int(1)         | 1 = User biasa, 2 = Admin (admin console, bukan admin meeting) |
| created_at  | timestamp      | Tanggal dibuat |
| updated_at  | timestamp      | Tanggal update |

---

### 2. `participant`
| Kolom       | Tipe Data       | Keterangan |
|-------------|----------------|------------|
| id          | int (PK, AI)   | Primary Key |
| user_id     | int (FK)       | Relasi ke `users.id` (ON DELETE CASCADE) |
| meeting_id  | int (FK)       | Relasi ke `roomMeeting.id`  (ON DELETE CASCADE) |
| join_time   | timestamp      | Waktu join ke meeting |
| leave_time  | timestamp      | Waktu keluar dari meeting |
| created_at  | timestamp      | Tanggal dibuat |
| updated_at  | timestamp      | Tanggal update |

---

### 3. `roomMeeting`
| Kolom        | Tipe Data       | Keterangan |
|--------------|----------------|------------|
| id           | int (PK, AI)   | Primary Key |
| password     | varchar(10)    | Password room |
| record       | boolean        | Status rekaman (true/false) |
| start        | timestamp      | Waktu mulai |
| end          | timestamp      | Waktu selesai |
| createdByUser| int (FK CASCADE)| Relasi ke `users.id` (ON DELETE CASCADE) |
| plan_id      | int (FK)       | Relasi ke `plan.id` (ON DELETE CASCADE) |
| updated_at   | timestamp      | Tanggal update |

---

### 4. `plan`
| Kolom       | Tipe Data       | Keterangan |
|-------------|----------------|------------|
| id          | int (PK, AI)   | Primary Key |
| plan_name   | varchar(50)    | Nama paket |
| max_participant | int(4)      | Jumlah maksimum peserta |
| price       | int            | Harga paket |
| created_at  | timestamp      | Tanggal dibuat |
| updated_at  | timestamp      | Tanggal update |

---

### 5. `premiumUsers`
| Kolom              | Tipe Data       | Keterangan |
|--------------------|----------------|------------|
| id                 | int (PK, AI)   | Primary Key |
| user_id            | int (FK)       | Relasi ke `users.id` (ON DELETE CASCADE) |
| plan_id            | int (FK)       | Relasi ke `plan.id` (ON DELETE CASCADE) |
| subscription_start | timestamp      | Awal langganan |
| subscription_end   | timestamp      | Akhir langganan |
| payment_status     | int(1)         | 0 = Menunggu, 1 = Berhasil |
| created_at         | timestamp      | Tanggal dibuat |
| updated_at         | timestamp      | Tanggal update |

---

### 6. `recordCloud`
| Kolom       | Tipe Data       | Keterangan |
|-------------|----------------|------------|
| id          | int (PK, AI)   | Primary Key |
| meeting_id  | int (FK)       | Relasi ke `roomMeeting.id` (ON DELETE CASCADE) |
| chat        | varchar        | Path file chat |
| video       | varchar        | Path File video |
| created_at  | timestamp      | Tanggal dibuat |
| updated_at  | timestamp      | Tanggal update |

---

## 🔗 Relasi Antar Tabel
- Ref: 'participant.user_id' > 'users.id' (**many to one**)
- Ref: 'participant.meeting_id' > 'roomMeeting.id' (**many to one**)
- Ref: 'roomMeeting.createdByUser' > 'users.id' (**many to one**)
- Ref: 'users.id' - 'premiumUsers.user_id' (**one to one**)
- Ref: 'plan.id' < 'premiumUsers.plan_id ' (**one to many**)
- Ref: 'recordCloud.meeting_id' - 'roomMeeting.id' (**one to one**)
- Ref: 'roomMeeting.plan_id' > 'plan.id' (**many to one**)
- Ref: 'participant.meeting_id' > 'recordCloud.meeting_id' (**many to one**)

---

## 📝 Catatan
- Masukkan data ke tabel **users** → role: `1 = User`, `2 = Admin`  
- Masukkan data ke tabel **plan** → daftar paket premium yang tersedia  
- Masukkan data ke tabel **roomMeeting** → contoh: meeting dengan ID `2` direkam.  
- Masukkan data ke tabel **participant** → peserta join ke meeting room  
- Masukkan data ke tabel **premiumUsers** → status pembayaran `0 = Menunggu`, `1 = Berhasil`  
- Masukkan data ke tabel **recordCloud** → nama file menggunakan **nama pengguna + ID rapat + tanggal end meeting** untuk deskripsi file yang lebih jelas.  
