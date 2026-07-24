# Ý tưởng hệ thống quản lý đặt vé xem phim (các chức năng cho từng role)

## Super Admin
- Cấp quyền admin
- Thống kê các doanh thu, lượt đặt vé, chi tiết qua từng cụm rạp chiếu, từng phim (tháng, quý, năm, ngày).
- Báo cáo số lượng tài khoản (tổng số tài khoản, số tài khoản admin, số tài khoản customer).
- Báo cáo số lượng phim, số lượng rạp, số lượng phòng chiếu, số lượng ghế.
- Báo cáo số lượng vé, số lượng vé đã bán, số lượng vé chưa bán.

## Admin
- Xem doanh thu (trang báo cáo, doanh thu đặt vé)
- Quản lý tài khoản user (thêm, quản lý trạng thái)
- Quản lý phim (thêm, xóa, update)
- Quản lý rạp chiếu (thêm rạp chiếu phim, thêm chi nhánh rạp) + Quản lý phòng chiếu (thêm, xóa, update) + Quản lý ghế (thêm, xóa, update) -> Quản lý rạp, phòng chiếu, ghế chiếu
- Quản lý lịch chiếu (thêm, xóa, update)
- Quản lý vé (thêm, xóa, update)
- Quản lý khuyến mãi (thêm, xóa, update)

## Customer
- Có thể xem thông tin của hệ thống
- Tìm kiếm thông tin theo phim, lọc theo thể loại
- Đặt vé xem phim (chọn lịch chiếu -> chọn ghế ( có thể chọn nhiều ghế) -> áp dụng voucher (nếu có) -> thanh toán)
- Thanh toán (thẻ ATM, momo, tài khoản ngân hàng)
- Xem lịch sử đặt vé, hóa đơn
- Review đánh giá phim (số sao từ 1 -> 5, comment review phim)

## Các chức năng chung
- Quản lý thông tin cá nhân của user (Role bất kỳ)
- Thay đổi mật khẩu, quên mất khẩu (gửi về mail)
- Đăng nhập/ Đăng ký/ Đăng xuất (SpringSecurity + jwt)
