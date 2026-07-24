-- 1. Roles (Vai trò)
INSERT INTO Roles (RoleName, Description) VALUES 
('Super Admin', 'Quản trị viên cấp cao nhất hệ thống'),
('Admin', 'Quản lý rạp và lịch chiếu'),
('Customer', 'Khách hàng thành viên'),
('Staff', 'Nhân viên soát vé tại rạp'),
('Manager', 'Quản lý chi nhánh rạp'),
('Support', 'Nhân viên chăm sóc khách hàng'),
('Marketing', 'Nhân viên quản lý khuyến mãi'),
('Auditor', 'Kiểm toán hệ thống');

-- 2. Users (Người dùng)
INSERT INTO Users (RoleID, Username, PasswordHash, Email, Phone, FullName, Status) VALUES 
(1, 'thont_admin', 'hashed_pwd_1', 'admin.tho@foodara.vn', '0901234567', 'Nguyễn Tá Thọ', 'Active'),
(2, 'cinemamanager', 'hashed_pwd_2', 'manager@foodara.vn', '0901234568', 'Trần Văn Quản Lý', 'Active'),
(3, 'khachhang1', 'hashed_pwd_3', 'kh1@gmail.com', '0901234569', 'Lê Thị Khách', 'Active'),
(3, 'khachhang2', 'hashed_pwd_4', 'kh2@gmail.com', '0901234570', 'Phạm Văn Mua', 'Active'),
(3, 'khachhang3', 'hashed_pwd_5', 'kh3@gmail.com', '0901234571', 'Hoàng Thị Hóng', 'Inactive'),
(3, 'khachhang4', 'hashed_pwd_6', 'kh4@gmail.com', '0901234572', 'Đặng Văn Phim', 'Active'),
(3, 'baduser99', 'hashed_pwd_7', 'spam@gmail.com', '0901234573', 'Kẻ Gian Lận', 'Banned'),
(4, 'staff_hcm_1', 'hashed_pwd_8', 'staff1@foodara.vn', '0901234574', 'Nguyễn Nhân Viên', 'Active');

-- 3. UserRoles
INSERT INTO UserRoles (UserID, RoleID) VALUES 
(1, 1), (2, 2), (3, 3), (4, 3), (5, 3), (6, 3), (7, 3), (8, 4);

-- 4. Movies (Phim)
INSERT INTO Movies (Title, Description, DurationMinutes, ReleaseDate, Language, Director, MovieCast, PosterURL, TrailerURL, Status) VALUES 
('Lật Mặt 7', 'Phim gia đình cảm động', 120, '2026-04-30', 'Tiếng Việt', 'Lý Hải', 'Nhiều diễn viên', '/img/lm7.jpg', '/vid/lm7.mp4', 'Now Showing'),
('Avengers: Secret Wars', 'Siêu anh hùng Marvel', 150, '2026-05-01', 'Tiếng Anh', 'Russo Brothers', 'Robert Downey Jr.', '/img/avg.jpg', '/vid/avg.mp4', 'Now Showing'),
('Mai', 'Phim tình cảm tâm lý', 130, '2026-02-14', 'Tiếng Việt', 'Trấn Thành', 'Phương Anh Đào', '/img/mai.jpg', '/vid/mai.mp4', 'Ended'),
('Dune: Part Three', 'Hành trình xứ cát', 160, '2026-10-15', 'Tiếng Anh', 'Denis Villeneuve', 'Timothée Chalamet', '/img/dune.jpg', '/vid/dune.mp4', 'Coming Soon'),
('Kung Fu Panda 5', 'Gấu Po trở lại', 95, '2026-06-01', 'Tiếng Anh', 'Mike Mitchell', 'Jack Black', '/img/kfp.jpg', '/vid/kfp.mp4', 'Coming Soon'),
('Bố Già 2', 'Tiếp nối câu chuyện', 110, '2026-12-20', 'Tiếng Việt', 'Trấn Thành', 'Tuấn Trần', '/img/bg2.jpg', '/vid/bg2.mp4', 'Coming Soon'),
('Godzilla vs Kong 3', 'Siêu quái thú đại chiến', 115, '2026-03-10', 'Tiếng Anh', 'Adam Wingard', 'Rebecca Hall', '/img/gvk.jpg', '/vid/gvk.mp4', 'Now Showing'),
('Doraemon Movie 2026', 'Chuyến phiêu lưu mới', 105, '2026-05-25', 'Tiếng Nhật', 'Shinnosuke Yakuwa', 'Wasabi Mizuta', '/img/dora.jpg', '/vid/dora.mp4', 'Now Showing');

-- 5. Genres (Thể loại)
INSERT INTO Genres (Name, Description) VALUES 
('Hành động', 'Phim có nhiều cảnh chiến đấu, rượt đuổi'),
('Hài hước', 'Phim mang tính giải trí, gây cười'),
('Tình cảm', 'Phim tâm lý, lãng mạn'),
('Kinh dị', 'Phim gây sợ hãi, hồi hộp'),
('Viễn tưởng', 'Phim khoa học không gian, tương lai'),
('Hoạt hình', 'Phim 2D, 3D dành cho gia đình'),
('Gia đình', 'Phim về tình cảm gia đình'),
('Phiêu lưu', 'Phim khám phá thế giới mới');

-- 6. Movie_Genres
INSERT INTO Movie_Genres (MovieID, GenreID) VALUES 
(1, 2), (1, 7), (2, 1), (2, 5), (3, 2), (3, 3), (4, 1), (4, 5), 
(5, 2), (5, 6), (6, 2), (6, 7), (7, 1), (7, 5), (8, 6), (8, 8);

-- 7. Cinemas (Cụm rạp)
INSERT INTO Cinemas (Name, Address, City, Phone, Email) VALUES 
('Foodara Cine Quận 9', 'Lê Văn Việt, TP. Thủ Đức', 'Hồ Chí Minh', '19001111', 'q9@foodara.vn'),
('Foodara Cine Quận 1', 'Vincom Đồng Khởi', 'Hồ Chí Minh', '19001112', 'q1@foodara.vn'),
('Foodara Cine Gò Vấp', 'Emart Gò Vấp', 'Hồ Chí Minh', '19001113', 'govap@foodara.vn'),
('Foodara Cine Cầu Giấy', 'Indochina Plaza', 'Hà Nội', '19001114', 'caugiay@foodara.vn'),
('Foodara Cine Hai Bà Trưng', 'Vincom Bà Triệu', 'Hà Nội', '19001115', 'hbt@foodara.vn'),
('Foodara Cine Hải Châu', 'Vincom Đà Nẵng', 'Đà Nẵng', '19001116', 'danang@foodara.vn'),
('Foodara Cine Ninh Kiều', 'Sense City', 'Cần Thơ', '19001117', 'cantho@foodara.vn'),
('Foodara Cine Đà Lạt', 'Quảng trường Lâm Viên', 'Đà Lạt', '19001118', 'dalat@foodara.vn');

-- 8. Halls (Phòng chiếu)
INSERT INTO Halls (CinemaID, Name, Type, Capacity) VALUES 
(1, 'Screen 1', '2D', 100),
(1, 'Screen 2 VIP', '2D', 50),
(2, 'IMAX Q1', 'IMAX', 200),
(2, 'Screen 4DX', '4DX', 80),
(3, 'Screen 1', '2D', 150),
(4, 'Screen 1', '3D', 120),
(5, 'Couple Room', '2D', 40),
(6, 'Screen 1', '2D', 100);

-- 9. Seats (Ghế ngồi - Mẫu cho Hall 1)
INSERT INTO Seats (HallID, SeatRow, Number, Type, PriceMultiplier) VALUES 
(1, 'A', 1, 'Standard', 1.00),
(1, 'A', 2, 'Standard', 1.00),
(1, 'D', 5, 'VIP', 1.50),
(1, 'D', 6, 'VIP', 1.50),
(1, 'H', 1, 'Couple', 2.00),
(1, 'H', 2, 'Couple', 2.00),
(3, 'E', 4, 'VIP', 1.50),
(3, 'E', 5, 'VIP', 1.50);

-- 10. Showtimes (Suất chiếu)
INSERT INTO Showtimes (MovieID, HallID, StartTime, EndTime, BasePrice, Status) VALUES 
(1, 1, '2026-07-15 18:00:00', '2026-07-15 20:00:00', 90000.00, 'Scheduled'),
(1, 1, '2026-07-15 20:30:00', '2026-07-15 22:30:00', 90000.00, 'Scheduled'),
(2, 3, '2026-07-16 19:00:00', '2026-07-16 21:30:00', 150000.00, 'Scheduled'),
(2, 4, '2026-07-16 20:00:00', '2026-07-16 22:30:00', 180000.00, 'Scheduled'),
(7, 2, '2026-07-15 17:00:00', '2026-07-15 18:55:00', 120000.00, 'Completed'),
(8, 5, '2026-07-17 09:00:00', '2026-07-17 10:45:00', 80000.00, 'Scheduled'),
(5, 6, '2026-08-01 14:00:00', '2026-08-01 15:35:00', 100000.00, 'Scheduled'),
(1, 1, '2026-07-14 18:00:00', '2026-07-14 20:00:00', 90000.00, 'Cancelled');


-- 11. Showtime_Seats (Trạng thái ghế của suất chiếu 1 và 3)
INSERT INTO Showtime_Seats (ShowtimeID, SeatID, Price, Status) VALUES 
(1, 1, 90000.00, 'Booked'),
(1, 2, 90000.00, 'Booked'),
(1, 3, 135000.00, 'Reserved'),
(1, 4, 135000.00, 'Available'),
(1, 5, 180000.00, 'Available'),
(1, 6, 180000.00, 'Available'),
(3, 7, 225000.00, 'Booked'),
(3, 8, 225000.00, 'Available');

-- 12. Coupons (Mã giảm giá)
INSERT INTO Coupons (Code, DiscountType, DiscountValue, ExpiryDate, UsageLimit, UsageCount, IsActive) VALUES 
('NEWUSER2026', 'Percentage', 20.00, '2026-12-31 23:59:59', 1000, 150, TRUE),
('GIAM50K', 'Fixed Amount', 50000.00, '2026-08-31 23:59:59', 500, 50, TRUE),
('SUMMER26', 'Percentage', 15.00, '2026-07-31 23:59:59', 200, 199, TRUE),
('EXPIRED10', 'Percentage', 10.00, '2025-12-31 23:59:59', 100, 0, FALSE),
('VIPONLY', 'Fixed Amount', 100000.00, '2026-12-31 23:59:59', 50, 10, TRUE),
('HSSV', 'Percentage', 10.00, '2026-12-31 23:59:59', 5000, 450, TRUE),
('T3VUIVE', 'Fixed Amount', 20000.00, '2026-12-31 23:59:59', 1000, 800, TRUE),
('NOEL2026', 'Percentage', 25.00, '2026-12-25 23:59:59', 300, 0, TRUE);

-- 13. Bookings (Đơn đặt vé)
INSERT INTO Bookings (UserID, ShowtimeID, CouponID, Status, TotalAmount) VALUES 
(3, 1, 1, 'Confirmed', 144000.00), -- 2 vé A1, A2 (180k - 20%)
(4, 3, 2, 'Confirmed', 175000.00), -- 1 vé E4 (225k - 50k)
(5, 1, NULL, 'Pending', 135000.00), -- Giữ chỗ D5
(6, 2, NULL, 'Cancelled', 270000.00), 
(3, 4, 3, 'Refunded', 153000.00), 
(4, 5, NULL, 'Confirmed', 120000.00),
(3, 7, 6, 'Confirmed', 90000.00),
(6, 8, NULL, 'Cancelled', 90000.00);

-- 14. Tickets (Chi tiết vé)
INSERT INTO Tickets (BookingID, ShowtimeSeatID, Price) VALUES 
(1, 1, 72000.00),
(1, 2, 72000.00),
(2, 7, 175000.00),
(3, 4, 135000.00),
(4, 5, 270000.00),
(5, 6, 153000.00),
(6, 3, 120000.00),
(7, 8, 90000.00);

-- 15. Payments (Thanh toán)
INSERT INTO Payments (BookingID, Amount, PaymentMethod, Status, TransactionID) VALUES 
(1, 144000.00, 'ZaloPay', 'Success', 'ZP2026071201'),
(2, 175000.00, 'Momo', 'Success', 'MM2026071202'),
(3, 135000.00, 'Credit Card', 'Pending', NULL),
(4, 270000.00, 'Cash', 'Failed', NULL),
(5, 153000.00, 'ZaloPay', 'Refunded', 'ZP2026071203'),
(6, 120000.00, 'Momo', 'Success', 'MM2026071204'),
(7, 90000.00, 'Credit Card', 'Success', 'CC2026071205'),
(8, 90000.00, 'ZaloPay', 'Failed', NULL);

-- 16. Reviews (Đánh giá)
INSERT INTO Reviews (UserID, MovieID, Rating, Comment) VALUES 
(3, 3, 5, 'Phim rất hay và cảm động, khóc quá trời!'),
(4, 3, 4, 'Nội dung ổn nhưng kết hơi buồn.'),
(6, 7, 3, 'Hành động mãn nhãn nhưng kịch bản hơi mỏng.'),
(3, 1, 5, 'Lý Hải làm phim ngày càng lên tay.'),
(4, 1, 5, 'Rất thích hợp xem cùng gia đình.'),
(5, 7, 4, 'Âm thanh rạp quá đỉnh, rung cả ghế.'),
(6, 2, 5, 'Không uổng công chờ đợi Marvel.'),
(3, 8, 4, 'Tuổi thơ ùa về, rất dễ thương.');

-- 17. Notifications (Thông báo)
INSERT INTO Notifications (UserID, Type, Content, IsRead) VALUES 
(3, 'Booking', 'Đơn hàng mua vé Lật Mặt 7 của bạn đã thành công.', TRUE),
(4, 'Booking', 'Thanh toán vé Avengers thất bại, vui lòng thử lại.', FALSE),
(3, 'Promotion', 'Tặng bạn mã GIAM50K cho lần đặt vé tiếp theo!', FALSE),
(5, 'System', 'Hệ thống sẽ bảo trì từ 2h-4h sáng mai.', TRUE),
(6, 'Promotion', 'Cuối tuần rồi, ra rạp xem phim thôi!', FALSE),
(3, 'Booking', 'Suất chiếu của bạn sẽ bắt đầu trong 30 phút nữa.', TRUE),
(4, 'System', 'Cập nhật điều khoản sử dụng hệ thống.', TRUE),
(8, 'System', 'Lịch làm việc tuần sau của bạn đã được cập nhật.', FALSE);