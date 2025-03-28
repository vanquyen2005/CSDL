CREATE DATABASE QuanLyDonHang1;
GO

USE QuanLyDonHang1;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tblKhachHang') AND type = N'U')
CREATE TABLE tblKhachHang (
    MaKhachHang INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100),
    SoDienThoai VARCHAR(15) UNIQUE,
    DiaChi NVARCHAR(255)
);
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tblNhanVienGiaoHang') AND type = N'U')
CREATE TABLE tblNhanVienGiaoHang (
    MaNhanVien INT PRIMARY KEY IDENTITY(1,1),
    HoTen NVARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(15) UNIQUE NOT NULL,
    SoDonGiao INT DEFAULT 0
);
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tblDonhang') AND type = N'U')
CREATE TABLE tblDonHang (
    MaDonHang INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT,
    NgayDat DATE,
    TrangThai NVARCHAR(20) CHECK (TrangThai IN (N'Chờ xử lý', N'Đang giao', N'Đã giao', N'Đã hủy')),
    TongTien DECIMAL(10,2),
    PhuongThucThanhToan NVARCHAR(20) CHECK (PhuongThucThanhToan IN (N'Tiền mặt', N'Chuyển khoản', N'Thẻ tín dụng')),
    FOREIGN KEY (MaKhachHang) REFERENCES tblKhachHang(MaKhachHang)
);
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tbSanpham') AND type = N'U')
CREATE TABLE tblSanPham (
    MaSanPham INT PRIMARY KEY IDENTITY(1,1),
    TenSanPham NVARCHAR(100) NOT NULL,
    DonGia DECIMAL(10, 2)
);
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tblChiTietDonHang') AND type = N'U')
CREATE TABLE tblChiTietDonHang (
    MaChiTiet INT PRIMARY KEY IDENTITY(1,1),
    MaDonHang INT,
    MaSanPham INT,
    SoLuong INT,
    DonGia DECIMAL(10,2),
	Tonkho INT,
    FOREIGN KEY (MaDonHang) REFERENCES tblDonHang(MaDonHang),
        FOREIGN KEY (MaSanPham) REFERENCES tblSanPham(MaSanPham)
);
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tblLichSuGiaoHang') AND type = N'U')
CREATE TABLE tblLichSuGiaoHang (
    MaGiaoHang INT PRIMARY KEY IDENTITY(1,1),
    MaDonHang INT,
    MaNhanVien INT,
    ThoiGianNhan DATETIME,
    ThoiGianGiao DATETIME,
    TrangThai NVARCHAR(20) CHECK (TrangThai IN (N'Đang giao', N'Đã giao', N'Bị hủy')),
    FOREIGN KEY (MaDonHang) REFERENCES tblDonHang(MaDonHang),
    FOREIGN KEY (MaNhanVien) REFERENCES tblNhanVienGiaoHang(MaNhanVien)
);
GO

INSERT INTO tblKhachHang (HoTen, SoDienThoai, DiaChi) VALUES
(N'Nguyễn Văn A', '0987654321', N'Hà Nội'),
(N'Trần Thị B', '0976543210', N'TP. Hồ Chí Minh'),
(N'Lê Văn C', '0965432109', N'Đà Nẵng'),
(N'Hoàng Minh D', '0956781234', N'Huế'),
(N'Phạm Thu E', '0945678123', N'Hải Phòng'),
(N'Ngô Quang F', '0934567812', N'Cần Thơ'),
(N'Bùi Thanh G', '0923456781', N'Bắc Giang'),
(N'Đinh Lan H', '0912345678', N'Quảng Ninh'),
(N'Lý Đức I', '0901234567', N'Nha Trang'),
(N'Trương Vĩnh K', '0898765432', N'Đồng Nai'),
(N'Khương LIều 7', '0898765437', N'Kom Tum'),
(N'VÕ Văn Q', '0898765473', N'Nghệ An'),
(N'Nguyễn Văn D', '0898765498', N'Bắc Giang'),
(N'Nguyễn Văn T', '0898765273', N'Long An'),
(N'Phạm Thị H', '0898765748', N'Đà Lạt');
GO

INSERT INTO tblNhanVienGiaoHang (HoTen, SoDienThoai) VALUES
(N'Phùng Gia Lâm','0123457891'),
(N'Đỗ Bảo Nam','0123457892'),
(N'Hoàng Mạnh Quân','0123457893'),
(N'Nguyễn Trung Đức','0123457894'),
(N'Trần Văn Hưng','0123457895'),
(N'Trần Đình Trọng ','0123457567'),  
(N'Nguyễn Đình ','0123457848'),
(N'Trần Quốc Tuấn','0123457859'),
(N'Bùi Anh Kiệt ','0123457869'),
(N'Ngô VĂn Đức','0123457950'),
(N'Trần Quang Diệu ','0123457847'),
(N'Trần Văn Sâm','0123457938'),
(N'Võ VĂn Nam','0123457837'),
(N'Lý A Kiều ','0123457843'),
(N'Trần Văn Sĩ','0123457832');
GO

INSERT INTO tblDonHang (MaKhachHang, NgayDat, TrangThai, TongTien, PhuongThucThanhToan) VALUES
(1, '2024-03-06', N'Chờ xử lý', 80000, N'Tiền mặt'),
(2, '2024-03-06', N'Đang giao', 20000, N'Chuyển khoản'),
(3, '2024-03-07', N'Đã giao', 10000, N'Thẻ tín dụng'),
(4, '2024-03-07', N'Đã hủy', 30000, N'Tiền mặt'),
(5, '2024-03-08', N'Đã hủy', 130000, N'Tiền mặt'), 
(6, '2024-03-08', N'Đang giao', 230000, N'Thẻ tín dụng'),
(7, '2024-03-09', N'Đã giao', 34000, N'Tiền mặt'),
(8, '2024-03-09', N'Đã hủy', 23000, N'Thẻ tín dụng'),
(9, '2024-03-10', N'Đang giao', 70000, N'Chuyển khoản'),
(10, '2024-03-10', N'Đã giao', 730000, N'Tiền mặt'),
(11, '2024-03-11', N'Đã giao', 330000, N'Chuyển khoản'),
(12, '2024-03-11', N'Đã giao', 64000, N'Tiền mặt'),
(13, '2024-03-12', N'Đã hủy', 90000, N'Thẻ tín dụng'),
(14, '2024-03-13', N'Đang giao', 30000, N'Tiền mặt'), 
(15, '2024-03-13', N'Đã hủy', 50000, N'Chuyển khoản');
GO

INSERT INTO tblSanPham (TenSanPham, DonGia) VALUES
(N'Bánh Quy', 25000),
(N'Nước ngọt', 10000),
(N'Sữa tươi', 20000),
(N'Bánh Mì', 10000),
(N'Bàn phím', 100000),
(N'Bia', 15000),
(N'Nước Suối ', 5000),
(N'Xôi', 15000),
(N'Chuột ', 50000),
(N'Đèn', 90000),
(N'Quần', 150000),
(N'Ốp Điện thoại', 34000),
(N'ổ điện', 120000),
(N'Giấy ăn ', 35000);
GO

INSERT INTO tblChiTietDonHang(MaDonHang,MaSanPham,SoLuong,DonGia) VALUES
(1,1,2,25000),
(2,2,3,10000),
(3,3,1,20000),
(4,4,1,10000),
(5,5,2,15000),
(6,6,3,100000),
(7,7,4,15000),
(8,8,3,5000),
(9,9,4,15000),
(10,10,5,50000),
(11,11,6,90000),
(12,12,3,150000),
(13,13,4,34000),
(14,14,1,120000),
(15,15,4,35000);
GO

INSERT INTO tblLichSuGiaoHang (MaDonHang, MaNhanVien, ThoiGianNhan, ThoiGianGiao, TrangThai) VALUES
(1, 1, '2024-03-07 08:00:00', ' 09:30:00', N'Đang giao'),
(2, 2, '2024-03-08 09:00:00', '2024-03-08 10:00:00', N'Đã giao'),
(3, 3, '2024-03-09 07:45:00', '2024-03-09 08:30:00', N'Đang giao'),
(4, 4, '2024-03-10 10:15:00', '2024-03-10 11:00:00', N'Đã giao'),
(5, 5, '2024-03-11 06:00:00', '2024-03-11 07:00:00', N'Đang giao'),
(6, 1, '2024-03-12 08:30:00', '2024-03-12 09:15:00', N'Đã giao'),
(7, 2, '2024-03-13 09:00:00', '2024-03-13 10:00:00', N'Bị hủy'),
(8, 3, '2024-03-14 11:00:00', '2024-03-14 12:00:00', N'Đã giao'),
(9, 4, '2024-03-15 07:30:00', '2024-03-15 08:30:00', N'Đang giao'),
(10, 5, '2024-03-16 08:00:00', '2024-03-16 09:00:00', N'Đã giao'),
(11, 1, '2024-03-17 06:45:00', '2024-03-17 07:30:00', N'Đang giao'),
(12, 2, '2024-03-18 07:15:00', '2024-03-18 08:00:00', N'Đã giao'),
(13, 3, '2024-03-19 09:30:00', '2024-03-19 10:30:00', N'Bị hủy'),
(14, 4, '2024-03-20 10:00:00', '2024-03-20 11:00:00', N'Đang giao'),
(15, 5, '2024-03-21 11:15:00', '2024-03-21 12:00:00', N'Đã giao');
Go


ALTER VIEW vw_ChiTietDonHang AS
SELECT ctdh.MaChiTiet, ctdh.MaDonHang, sp.TenSanPham, ctdh.SoLuong, ctdh.DonGia
FROM tblChiTietDonHang ctdh
JOIN tblSanPham sp ON ctdh.MaSanPham = sp.MaSanPham;
GO

ALTER VIEW vw_DonHang_ChoXuLy AS
SELECT * FROM tblDonHang WHERE TrangThai = N'Chờ xử lý';
GO

ALTER VIEW vw_NhanVienGiaoHang AS
SELECT nv.MaNhanVien, nv.HoTen, nv.SoDienThoai, COUNT(lsgh.MaDonHang) AS SoDonDaGiao
FROM tblNhanVienGiaoHang nv
LEFT JOIN tblLichSuGiaoHang lsgh ON nv.MaNhanVien = lsgh.MaNhanVien AND lsgh.TrangThai = N'Đã giao'
GROUP BY nv.MaNhanVien, nv.HoTen, nv.SoDienThoai;
GO


ALTER VIEW vw_DonHang_DaHuy AS
SELECT * FROM tblDonHang WHERE TrangThai = N'Đã hủy';
GO

ALTER VIEW vw_DonHang_TheoPhuongThucThanhToan AS
SELECT PhuongThucThanhToan, COUNT(*) AS SoLuongDon, SUM(TongTien) AS TongTien
FROM tblDonHang
GROUP BY PhuongThucThanhToan;
GO


ALTER VIEW vw_DoanhThu_TheoNgay AS
SELECT NgayDat, SUM(TongTien) AS TongDoanhThu
FROM tblDonHang
GROUP BY NgayDat;
GO


ALTER VIEW vw_SanPham_BanChay AS
SELECT sp.MaSanPham, sp.TenSanPham, SUM(ctdh.SoLuong) AS TongSoLuongBan
FROM tblChiTietDonHang ctdh
JOIN tblSanPham sp ON ctdh.MaSanPham = sp.MaSanPham
GROUP BY sp.MaSanPham, sp.TenSanPham;
GO


ALTER VIEW vw_LichSuGiaoHang AS
SELECT lsgh.MaGiaoHang, lsgh.MaDonHang, kh.HoTen AS TenKhachHang, nv.HoTen AS TenNhanVien, lsgh.ThoiGianNhan, lsgh.ThoiGianGiao, lsgh.TrangThai
FROM tblLichSuGiaoHang lsgh
JOIN tblDonHang dh ON lsgh.MaDonHang = dh.MaDonHang
JOIN tblKhachHang kh ON dh.MaKhachHang = kh.MaKhachHang
JOIN tblNhanVienGiaoHang nv ON lsgh.MaNhanVien = nv.MaNhanVien;
GO

ALTER VIEW vw_SoLuongDonHang_TheoTrangThai AS
SELECT TrangThai, COUNT(*) AS SoLuongDon
FROM tblDonHang
GROUP BY TrangThai;
GO

ALTER VIEW vw_TongTien_DonHang_KhachHang AS
SELECT kh.MaKhachHang, kh.HoTen, SUM(dh.TongTien) AS TongTienDonHang
FROM tblDonHang dh
JOIN tblKhachHang kh ON dh.MaKhachHang = kh.MaKhachHang
GROUP BY kh.MaKhachHang, kh.HoTen;
GO

ALTER PROCEDURE sp_ThemKhachHang
    @HoTen NVARCHAR(100),
    @SoDienThoai VARCHAR(15),
    @DiaChi NVARCHAR(255)
AS
BEGIN
    INSERT INTO tblKhachHang (HoTen, SoDienThoai, DiaChi)
    VALUES (@HoTen, @SoDienThoai, @DiaChi);
END;
GO

ALTER  PROCEDURE sp_LayDonHangTheoTrangThai
    @TrangThai NVARCHAR(20)
AS
BEGIN
    SELECT * FROM tblDonHang WHERE TrangThai = @TrangThai;
END;
GO

ALTER  PROCEDURE sp_CapNhatTrangThaiDonHang
    @MaDonHang INT,
    @TrangThai NVARCHAR(20)
AS
BEGIN
    UPDATE tblDonHang
    SET TrangThai = @TrangThai
    WHERE MaDonHang = @MaDonHang;
END;
GO

ALTER  PROCEDURE sp_LayDanhSachSanPham
AS
BEGIN
    SELECT * FROM tblSanPham;
END;
GO

ALTER PROCEDURE sp_ThemDonHang
    @MaKhachHang INT,
    @NgayDat DATE,
    @TrangThai NVARCHAR(20),
    @TongTien DECIMAL(10,2),
    @PhuongThucThanhToan NVARCHAR(20)
AS
BEGIN
    INSERT INTO tblDonHang (MaKhachHang, NgayDat, TrangThai, TongTien, PhuongThucThanhToan)
    VALUES (@MaKhachHang, @NgayDat, @TrangThai, @TongTien, @PhuongThucThanhToan);
END;
GO

ALTER  PROCEDURE sp_LayDoanhThuTheoNgay
AS
BEGIN
    SELECT NgayDat, SUM(TongTien) AS TongDoanhThu
    FROM tblDonHang
    GROUP BY NgayDat;
END;
GO

ALTER PROCEDURE sp_LayDanhSachNhanVienGiaoHang
AS
BEGIN
    SELECT * FROM tblNhanVienGiaoHang;
END;
GO

ALTER PROCEDURE sp_LayLichSuGiaoHangTheoNhanVien
    @MaNhanVien INT
AS
BEGIN
    SELECT * FROM tblLichSuGiaoHang WHERE MaNhanVien = @MaNhanVien;
END;
GO

ALTER PROCEDURE sp_LayKhachHangTheoSoDienThoai
    @SoDienThoai VARCHAR(15)
AS
BEGIN
    SELECT * FROM tblKhachHang WHERE SoDienThoai = @SoDienThoai;
END;
GO

ALTER PROCEDURE sp_LayDonHangCuaKhachHang
    @MaKhachHang INT
AS
BEGIN
    SELECT * FROM tblDonHang WHERE MaKhachHang = @MaKhachHang;
END;
GO

CREATE TRIGGER trg_KiemTraSoLuongTruocKhiThem
ON tblChiTietDonHang
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @MaSanPham INT, @SoLuong INT;

    SELECT @MaSanPham = MaSanPham, @SoLuong = SoLuong
    FROM inserted;

    IF (@SoLuong > 50)
    BEGIN
        RAISERROR('Số lượng sản phẩm không được vượt quá 50!', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO tblChiTietDonHang (MaDonHang, MaSanPham, SoLuong, DonGia)
    SELECT MaDonHang, MaSanPham, SoLuong, DonGia FROM inserted;
END;
GO

CREATE TRIGGER trg_ThongBaoDonHangMoi
ON tblChiTietDonHang
AFTER INSERT
AS
BEGIN
    DECLARE @MaSanPham INT, @SoLuong INT, @MaDonHang INT;

    SELECT @MaSanPham = MaSanPham, @SoLuong = SoLuong, @MaDonHang = MaDonHang
    FROM inserted;
	PRINT 'Thông báo: Đơn hàng mới đã được thêm. Mã đơn hàng: ' + CAST(@MaDonHang AS NVARCHAR(10)) + ', Mã sản phẩm: ' + CAST(@MaSanPham AS NVARCHAR(10)) + ', Số lượng: ' + CAST(@SoLuong AS NVARCHAR(10));
END;
GO

CREATE TRIGGER trg_ThongBaoDonHangHuy
ON tblDonHang
AFTER UPDATE
AS
BEGIN
    IF UPDATE(TrangThai)
    BEGIN
        DECLARE @MaDonHang INT, @TrangThai NVARCHAR(20);
        SELECT @MaDonHang = MaDonHang, @TrangThai = TrangThai FROM inserted;

        IF @TrangThai = N'Đã hủy'
        BEGIN
            PRINT 'Thông báo: Đơn hàng ' + CAST(@MaDonHang AS NVARCHAR(10)) + ' đã bị hủy.';
        END
    END
END;
GO

CREATE TRIGGER trg_CapNhatSoDonGiao
ON tblLichSuGiaoHang
AFTER INSERT
AS
BEGIN
    DECLARE @MaNhanVien INT;

    SELECT @MaNhanVien = MaNhanVien FROM inserted;

    UPDATE tblNhanVienGiaoHang
    SET SoDonGiao = SoDonGiao + 1
    WHERE MaNhanVien = @MaNhanVien; 
END;
GO

CREATE TRIGGER trg_KiemTraGiaTriDonHangToiThieu
ON tblDonHang
AFTER INSERT
AS
BEGIN
    DECLARE @TongTien DECIMAL(10,2);

    SELECT @TongTien = TongTien FROM inserted;

    IF (@TongTien < 10000)
    BEGIN
        RAISERROR('Số tiền đơn hàng tối thiểu là 10000!', 16, 1);
        ROLLBACK TRANSACTION; 
        RETURN;
    END
END;
GO

CREATE TRIGGER trg_CapNhatSoDienThoaiKhachHang
ON tblKhachHang
AFTER UPDATE
AS
BEGIN
    DECLARE @MaKhachHang INT, @SoDienThoai VARCHAR(15);

    SELECT @MaKhachHang = MaKhachHang, @SoDienThoai = SoDienThoai FROM inserted;

    UPDATE tblKhachHang
    SET SoDienThoai = @SoDienThoai
    WHERE MaKhachHang = @MaKhachHang; 
END;
GO

CREATE TRIGGER trg_XoaDonHangKhiKhachHangBiXoa
ON tblKhachHang
AFTER DELETE
AS
BEGIN
    DECLARE @MaKhachHang INT;

    SELECT @MaKhachHang = MaKhachHang FROM deleted;

    DELETE FROM tblDonHang WHERE MaKhachHang = @MaKhachHang;
    DELETE FROM tblChiTietDonHang WHERE MaDonHang IN (SELECT MaDonHang FROM tblDonHang WHERE MaKhachHang = @MaKhachHang);
End;
GO

CREATE TRIGGER trg_CapNhatTrangThaiDonHangKhiThoiGianGiaoDuocDuyet
ON tblLichSuGiaoHang
AFTER UPDATE
AS
BEGIN
    DECLARE @MaDonHang INT;

    SELECT @MaDonHang = MaDonHang FROM inserted;

    IF EXISTS (SELECT 1 FROM tblLichSuGiaoHang WHERE MaDonHang = @MaDonHang AND ThoiGianGiao <= GETDATE())
    BEGIN
        UPDATE tblDonHang
        SET TrangThai = N'Đã giao'
        WHERE MaDonHang = @MaDonHang; 
    END
END;
GO

ALTER TRIGGER trg_CapNhatTongTienDonHang
ON tblChiTietDonHang
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dh
    SET dh.TongTien = (
        SELECT SUM(ctdh.SoLuong * ctdh.DonGia)
        FROM tblChiTietDonHang ctdh
        WHERE ctdh.MaDonHang = dh.MaDonHang
    )
    FROM tblDonHang dh
    WHERE dh.MaDonHang IN (SELECT DISTINCT MaDonHang FROM inserted UNION SELECT DISTINCT MaDonHang FROM deleted);
END;
GO

SELECT * FROM tblKhachHang;
SELECT * FROM tblNhanVienGiaoHang;
SELECT * FROM tblDonHang;
SELECT * FROM tblSanPham;
SELECT MaDonHang FROM tblDonHang;
SELECT * FROM tblLichSuGiaoHang;

SELECT * FROM vw_ChiTietDonHang;
SELECT * FROM vw_DonHang_ChoXuLy;
SELECT * FROM vw_NhanVienGiaoHang;
SELECT * FROM vw_DonHang_DaHuy;
SELECT * FROM vw_DonHang_TheoPhuongThucThanhToan;
SELECT * FROM vw_DoanhThu_TheoNgay;
SELECT * FROM vw_SanPham_BanChay;
SELECT * FROM vw_LichSuGiaoHang;
SELECT * FROM vw_SoLuongDonHang_TheoTrangThai;
SELECT * FROM vw_TongTien_DonHang_KhachHang;

SELECT * FROM tblKhachHang WHERE SoDienThoai = '0901234567';
EXEC sp_LayDonHangTheoTrangThai @TrangThai = N'Đang giao';
SELECT * FROM tblDonHang WHERE MaDonHang = 1;
EXEC sp_LayDanhSachSanPham;
SELECT * FROM tblDonHang WHERE MaKhachHang = 1 AND NgayDat = '2023-10-27';
EXEC sp_LayDoanhThuTheoNgay;
EXEC sp_LayDanhSachNhanVienGiaoHang;
EXEC sp_LayKhachHangTheoSoDienThoai @SoDienThoai = '0901234567';
EXEC sp_LayDonHangCuaKhachHang @MaKhachHang = 1;