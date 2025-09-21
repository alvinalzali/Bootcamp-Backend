-- Masukan data ke tabel users
-- Peran: 1 = User biasa, 2 = Admin, admin disini yang mengurus page console admin, jadi bukan artinya dia admin meeting
INSERT INTO users (email, password, name, role) VALUES
('budi.santoso@gmail.com', 'hashed_password_1', 'Budi Santoso', 2), -- Admin
('siti.amalia@gmail.com', 'hashed_password_2', 'Siti Amalia', 1),
('joko.prasetyo@gmail.com', 'hashed_password_3', 'Joko Prasetyo', 1),
('indah.kusuma@gmail.com', 'hashed_password_4', 'Indah Kusuma', 1);

--
-- Masukan data ke tabel plan, tabel ini untuk list plan paket apa saja yang dapat digunakan
INSERT INTO plan (plan_name, max_participant, price) VALUES
('Paket Dasar', 10, 50000),
('Paket Premium', 50, 150000),
('Paket Bisnis', 200, 500000);

--
-- Masukan data ke tabel roomMeeting
-- Catatan: Rapat dengan ID 2 akan direkam. createdByUser adalah id admin dari meeting room tersebut
INSERT INTO roommeeting (password, plan_id, record, timestart, timeend, createdbyuser) VALUES
(1234, 1, FALSE, '2025-09-21 14:00:00', '2025-09-21 15:00:00', 2),
(5678, 2, TRUE, '2025-09-20 10:30:00', '2025-09-20 11:30:00', 3),
(9101, 3, FALSE, '2025-09-22 09:00:00', '2025-09-22 10:00:00', 1);

--
-- Masukan data ke tabel participant
-- Peserta meeting join ke meeting room
INSERT INTO participant (user_id, meeting_id, join_time, leave_time) VALUES
(1, 2, '2025-09-20 10:35:00', '2025-09-20 11:20:00'),
(2, 2, '2025-09-20 10:30:00', '2025-09-20 11:30:00'),
(4, 2, '2025-09-20 10:40:00', '2025-09-20 11:15:00'),
(2, 3, '2025-09-22 09:05:00', '2025-09-22 09:50:00');

--
-- Masukan data ke tabel 'premium_users'
-- Status Pembayaran: 0 = Menunggu, 1 = Berhasil
-- Tabel ini juga memberitahu admin dan pengguna untuk mengetahui batas paket yang dibeli
INSERT INTO premiumusers (user_id, plan_id, subscription_start, subscription_end, payment_status) VALUES
(1, 3, '2025-09-01 00:00:00', '2025-10-01 00:00:00', 1),
(4, 2, '2025-09-15 00:00:00', '2025-10-15 00:00:00', 1);

--
-- Masukan data ke tabel 'record_cloud'
-- Nama file menggunakan nama pengguna, ID rapat dan tanggal end meeting untuk deskripsi file yang lebih jelas.
INSERT INTO recordcloud (meeting_id, chatfile, videofile) VALUES
(2, 'file_chat_joko_prasetyo_rapat_2_2025-09-22.txt', 'file_video_joko_prasetyo_rapat_2_2025-09-22.mp4');
