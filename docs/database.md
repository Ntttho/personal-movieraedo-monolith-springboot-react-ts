# Thiết kế Cơ sở dữ liệu: Hệ thống Quản lý Vé Xem Phim

Tài liệu này mô tả chi tiết thiết kế cơ sở dữ liệu cho hệ thống đặt vé xem phim. Hệ thống hỗ trợ 3 vai trò chính: **Super Admin** (Quản lý toàn bộ), **Admin** (Quản lý rạp chiếu, lịch chiếu phim) và **Customer** (Khách hàng đặt vé).

## Danh sách các bảng, Kiểu dữ liệu và Mô tả chi tiết

### 1. Phân quyền và Người dùng

#### 1.1. Roles (Vai trò người dùng)
Định nghĩa các cấp độ quyền hạn trong hệ thống.
* `RoleID` (INT, PK, AUTO_INCREMENT): Mã vai trò định danh.
* `RoleName` (VARCHAR(50), NOT NULL, UNIQUE): Tên vai trò (VD: 'Super Admin', 'Admin', 'Customer').
* `Description` (VARCHAR(255), NULL): Mô tả chi tiết về quyền hạn của vai trò.

#### 1.2. Users (Người dùng)
Lưu trữ thông tin tài khoản của khách hàng và ban quản trị.
* `UserID` (INT, PK, AUTO_INCREMENT): Mã định danh người dùng.
* `RoleID` (INT, FK -> UserRoles.RoleID, NOT NULL): Khóa ngoại liên kết xác định vai trò người dùng.
* `Username` (VARCHAR(50), NOT NULL, UNIQUE): Tên đăng nhập.
* `PasswordHash` (VARCHAR(255), NOT NULL): Mật khẩu đã được mã hóa (hash) để bảo mật.
* `Email` (VARCHAR(100), NOT NULL, UNIQUE): Địa chỉ email liên hệ.
* `Phone` (VARCHAR(20), UNIQUE): Số điện thoại liên hệ.
* `FullName` (VARCHAR(100), NOT NULL): Họ và tên đầy đủ.
* `AvatarURL` (VARCHAR(255), NULL): Đường dẫn tới ảnh đại diện của người dùng.
* `Status` (ENUM('Active', 'Inactive', 'Banned'), DEFAULT 'Active'): Trạng thái tài khoản.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP): Thời gian tạo tài khoản.
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP): Thời gian cập nhật thông tin.

#### 1.3. UserRoles (Bảng trung gian: Người dùng - Vai trò)
Thể hiện mối quan hệ **Nhiều-Nhiều (Many-to-Many)** giữa Người dùng và Vai trò
* `UserID` (INT, PK, FK -> Users.UserID): Khóa ngoại trỏ về bảng Người dùng.
* `RoleID` (INT, PK, FK -> Roles.RoleID): Khóa ngoại trỏ về bảng Vai trò.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP): Thời gian tạo.
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP): Thời gian cập nhật.

### 2. Quản lý Phim

#### 2.1. Movies (Thông tin phim)
Lưu trữ các thông tin chi tiết về các bộ phim.
* `MovieID` (INT, PK, AUTO_INCREMENT): Mã định danh bộ phim.
* `Title` (VARCHAR(255), NOT NULL): Tên bộ phim.
* `Description` (TEXT, NULL): Tóm tắt nội dung phim.
* `DurationMinutes` (INT, NOT NULL): Thời lượng phim (tính bằng phút).
* `ReleaseDate` (DATE, NOT NULL): Ngày khởi chiếu.
* `Language` (VARCHAR(50)): Ngôn ngữ của phim (VD: Tiếng Anh, Tiếng Việt).
* `Director` (VARCHAR(100)): Tên đạo diễn.
* `Cast` (TEXT): Danh sách diễn viên chính.
* `PosterURL` (VARCHAR(255)): Đường dẫn ảnh bìa phim.
* `TrailerURL` (VARCHAR(255)): Đường dẫn video trailer phim.
* `Status` (ENUM('Coming Soon', 'Now Showing', 'Ended'), DEFAULT 'Coming Soon'): Tình trạng của bộ phim (Sắp chiếu, Đang chiếu, Ngừng chiếu).
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

#### 2.2. Genres (Thể loại phim)
Danh mục các thể loại phim.
* `GenreID` (INT, PK, AUTO_INCREMENT): Mã thể loại.
* `Name` (VARCHAR(100), NOT NULL, UNIQUE): Tên thể loại (VD: Hành động, Hài, Kinh dị).
* `Description` (TEXT, NULL): Mô tả thêm về thể loại.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

#### 2.3. Movie_Genres (Bảng trung gian: Phim - Thể loại)
Thể hiện mối quan hệ **Nhiều-Nhiều (Many-to-Many)** giữa Phim và Thể loại (Một phim có thể thuộc nhiều thể loại, một thể loại có nhiều phim).
* `MovieID` (INT, PK, FK -> Movies.MovieID): Khóa ngoại trỏ về bảng Phim.
* `GenreID` (INT, PK, FK -> Genres.GenreID): Khóa ngoại trỏ về bảng Thể loại.

### 3. Quản lý Rạp, Phòng Chiếu và Ghế

#### 3.1. Cinemas (Cụm rạp phim)
Lưu trữ thông tin các cơ sở/chi nhánh rạp chiếu phim.
* `CinemaID` (INT, PK, AUTO_INCREMENT): Mã rạp chiếu.
* `Name` (VARCHAR(100), NOT NULL): Tên rạp (VD: CGV Vincom, Lotte Cinema).
* `Address` (VARCHAR(255), NOT NULL): Địa chỉ cụ thể của rạp.
* `City` (VARCHAR(100), NOT NULL): Thành phố nơi rạp hoạt động.
* `Phone` (VARCHAR(20)): Số điện thoại tổng đài của rạp.
* `Email` (VARCHAR(100)): Email liên hệ của rạp.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

#### 3.2. Halls (Phòng chiếu)
Các phòng chiếu vật lý thuộc một rạp cụ thể.
* `HallID` (INT, PK, AUTO_INCREMENT): Mã phòng chiếu.
* `CinemaID` (INT, FK -> Cinemas.CinemaID, NOT NULL): Thuộc rạp chiếu nào.
* `Name` (VARCHAR(50), NOT NULL): Tên hoặc số phòng chiếu (VD: Screen 1, Screen 2, Phòng VIP).
* `Type` (ENUM('2D', '3D', 'IMAX', '4DX'), DEFAULT '2D'): Loại công nghệ chiếu.
* `Capacity` (INT, NOT NULL): Tổng số lượng ghế có trong phòng.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

#### 3.3. Seats (Ghế ngồi vật lý)
Lưu sơ đồ thiết kế ghế cố định của từng phòng chiếu.
* `SeatID` (INT, PK, AUTO_INCREMENT): Mã ghế.
* `HallID` (INT, FK -> Halls.HallID, NOT NULL): Nằm trong phòng chiếu nào.
* `Row` (VARCHAR(5), NOT NULL): Hàng ghế (VD: A, B, C, D).
* `Number` (INT, NOT NULL): Số thứ tự ghế trong hàng (VD: 1, 2, 3).
* `Type` (ENUM('Standard', 'VIP', 'Couple'), DEFAULT 'Standard'): Loại ghế (ảnh hưởng đến giá tiền).
* `PriceMultiplier` (DECIMAL(3,2), DEFAULT 1.0): Hệ số giá (VD: Ghế Standard hệ số 1.0, ghế VIP hệ số 1.5 nhân với giá vé cơ bản của suất chiếu).
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

### 4. Lịch Chiếu và Đặt Vé

#### 4.1. Showtimes (Lịch chiếu phim)
Sắp xếp bộ phim nào chiếu ở rạp nào, phòng nào, vào khung giờ nào.
* `ShowtimeID` (INT, PK, AUTO_INCREMENT): Mã suất chiếu.
* `MovieID` (INT, FK -> Movies.MovieID, NOT NULL): Suất chiếu chiếu bộ phim nào.
* `HallID` (INT, FK -> Halls.HallID, NOT NULL): Diễn ra tại phòng chiếu nào (từ đây hệ thống có thể truy ra Rạp - Cinema).
* `StartTime` (DATETIME, NOT NULL): Thời gian bắt đầu suất chiếu.
* `EndTime` (DATETIME, NOT NULL): Thời gian kết thúc.
* `BasePrice` (DECIMAL(10,2), NOT NULL): Giá vé cơ bản cho suất chiếu này (VD: 90,000 VND).
* `Status` (ENUM('Scheduled', 'Ongoing', 'Completed', 'Cancelled'), DEFAULT 'Scheduled'): Trạng thái lịch chiếu.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

#### 4.2. Showtime_Seats (Bảng trung gian: Suất chiếu - Ghế ngồi)
Thể hiện tương tác giữa **Suất chiếu** và **Ghế ngồi**. Do mỗi suất chiếu sẽ có một tập hợp các ghế bị trống/đã đặt riêng biệt, bảng này sinh ra để đánh dấu trạng thái thực tế của từng ghế trong từng suất chiếu cụ thể nhằm chống trùng lặp (Double Booking).
* `ShowtimeSeatID` (INT, PK, AUTO_INCREMENT): Mã trạng thái ghế của suất chiếu.
* `ShowtimeID` (INT, FK -> Showtimes.ShowtimeID, NOT NULL): Thuộc suất chiếu nào.
* `SeatID` (INT, FK -> Seats.SeatID, NOT NULL): Thuộc chiếc ghế nào trong phòng chiếu.
* `Price` (DECIMAL(10,2), NOT NULL): Giá vé thực tế của ghế này (Bằng `BasePrice` của Showtimes * `PriceMultiplier` của Seats).
* `Status` (ENUM('Available', 'Reserved', 'Booked'), DEFAULT 'Available'): Trạng thái hiện tại của ghế (Còn trống, Đang giữ chỗ, Đã mua thành công).

#### 4.3. Bookings (Đơn đặt vé)
Quản lý tổng thể 1 giao dịch mua vé của người dùng (1 đơn có thể gồm nhiều vé).
* `BookingID` (INT, PK, AUTO_INCREMENT): Mã đơn hàng đặt vé.
* `UserID` (INT, FK -> Users.UserID, NOT NULL): Người thực hiện đặt vé.
* `ShowtimeID` (INT, FK -> Showtimes.ShowtimeID, NOT NULL): Đơn hàng này thuộc về suất chiếu nào.
* `CouponID` (INT, FK -> Coupons.CouponID, NULL): Mã giảm giá được áp dụng trong đơn (nếu có).
* `BookingDate` (DATETIME, DEFAULT CURRENT_TIMESTAMP): Thời gian bắt đầu tạo đơn đặt vé.
* `Status` (ENUM('Pending', 'Confirmed', 'Cancelled', 'Refunded'), DEFAULT 'Pending'): Trạng thái của toàn bộ đơn hàng (Chờ thanh toán, Đã xác nhận...).
* `TotalAmount` (DECIMAL(10,2), NOT NULL): Tổng tiền khách phải thanh toán (sau khi cộng các vé và trừ giảm giá).
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

#### 4.4. Tickets (Bảng trung gian: Đơn đặt - Ghế suất chiếu)
Thể hiện mối quan hệ **Nhiều-Nhiều (Many-to-Many)** giữa Đơn đặt (Bookings) và Ghế suất chiếu (Showtime_Seats). Chi tiết từng chiếc vé rời nằm bên trong một Đơn đặt.
* `TicketID` (INT, PK, AUTO_INCREMENT): Mã vé (định danh chiếc vé vật lý hoặc vé điện tử QR).
* `BookingID` (INT, FK -> Bookings.BookingID, NOT NULL): Vé này nằm trong đơn hàng nào.
* `ShowtimeSeatID` (INT, FK -> Showtime_Seats.ShowtimeSeatID, NOT NULL): Vé này được cấp cho chỗ ngồi nào trong suất chiếu.
* `Price` (DECIMAL(10,2), NOT NULL): Giá tiền của riêng chiếc vé này tại thời điểm thanh toán thành công.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)

### 5. Thanh Toán và Khuyến Mãi

#### 5.1. Payments (Lịch sử giao dịch thanh toán)
Lưu lại giao dịch dòng tiền đối với các đơn đặt.
* `PaymentID` (INT, PK, AUTO_INCREMENT): Mã giao dịch thanh toán.
* `BookingID` (INT, FK -> Bookings.BookingID, NOT NULL): Thanh toán cho đơn đặt nào.
* `Amount` (DECIMAL(10,2), NOT NULL): Số tiền khách thực tế chuyển khoản/quẹt thẻ.
* `PaymentMethod` (ENUM('Credit Card', 'Momo', 'ZaloPay', 'Cash'), NOT NULL): Phương thức thanh toán khách đã dùng.
* `Status` (ENUM('Pending', 'Success', 'Failed', 'Refunded'), DEFAULT 'Pending'): Trạng thái từ cổng thanh toán.
* `TransactionID` (VARCHAR(100), NULL): Mã giao dịch đối soát trả về từ ngân hàng hoặc ví điện tử (Momo/ZaloPay).
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

#### 5.2. Coupons (Mã giảm giá/Khuyến mãi)
Danh sách các mã khuyến mãi mà Admin tạo để marketing.
* `CouponID` (INT, PK, AUTO_INCREMENT): Mã quản lý coupon nội bộ.
* `Code` (VARCHAR(50), NOT NULL, UNIQUE): Đoạn mã khách hàng nhập để nhận khuyến mãi (VD: SALE50, YEUPHIM).
* `DiscountType` (ENUM('Percentage', 'Fixed Amount'), NOT NULL): Kiểu giảm giá (Theo % hay Giảm một số tiền cố định).
* `DiscountValue` (DECIMAL(10,2), NOT NULL): Mức giảm tương ứng (VD: 10% hoặc 50,000 VND).
* `ExpiryDate` (DATETIME, NOT NULL): Ngày hết hạn.
* `UsageLimit` (INT, DEFAULT 100): Tổng số lượt mã này có thể được xài trên toàn hệ thống.
* `UsageCount` (INT, DEFAULT 0): Số lượt mã này đã được sử dụng thành công thực tế.
* `IsActive` (BOOLEAN, DEFAULT TRUE): Công tắc Bật/Tắt mã khuyến mãi.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

### 6. Đánh giá và Tương tác Người Dùng

#### 6.1. Reviews (Đánh giá phim)
Nơi khách hàng để lại bình luận và điểm số sao sau khi xem phim.
* `ReviewID` (INT, PK, AUTO_INCREMENT): Mã đánh giá.
* `UserID` (INT, FK -> Users.UserID, NOT NULL): Khách hàng thực hiện đánh giá.
* `MovieID` (INT, FK -> Movies.MovieID, NOT NULL): Đánh giá dành cho bộ phim nào.
* `Rating` (TINYINT, NOT NULL): Điểm số đánh giá, giới hạn (VD: Từ 1 đến 5 sao).
* `Comment` (TEXT, NULL): Nội dung lời nhận xét.
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)
* `UpdatedAt` (DATETIME, ON UPDATE CURRENT_TIMESTAMP)

#### 6.2. Notifications (Thông báo)
Lưu các thông báo được đẩy (push notification) tới người dùng.
* `NotificationID` (INT, PK, AUTO_INCREMENT): Mã thông báo.
* `UserID` (INT, FK -> Users.UserID, NOT NULL): Thông báo gửi đến ai.
* `Type` (ENUM('System', 'Promotion', 'Booking'), NOT NULL): Phân loại thông báo (VD: Nhắc giờ chiếu, mã khuyến mãi, thay đổi hệ thống).
* `Content` (TEXT, NOT NULL): Nội dung chữ của thông báo.
* `IsRead` (BOOLEAN, DEFAULT FALSE): Trạng thái xem (Khách hàng đã đọc hay chưa).
* `CreatedAt` (DATETIME, DEFAULT CURRENT_TIMESTAMP)