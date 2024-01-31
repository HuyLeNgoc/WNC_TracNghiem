create database DB_ThiTracNghiem

create table tblNguoiDung(
  PK_MaNguoiDung int identity(1,1) primary key,
  sEmail varchar(50),
  sHoTen nvarchar(50),
  sMatKhau nvarchar(max)
)

create table tblBaiThi(
	PK_MaBaiThi int identity(1,1) primary key,
	sTieuDe nvarchar(50),
	dNgayTao datetime default getDate(),
	iSoLuongCauHoi int,
	iThoiGianLamBai int,
	sMoTaChung nvarchar(100),
	sMaCaThi nvarchar(50)      
)

--thêm cột số câu hỏi đã thêm
alter table tblBaiThi
add iSoCauHoiDaThem int default 0

--tạo trigger thêm câu hỏi tự động tăng iSoCauHoiDaThem
CREATE TRIGGER TG_SoLuongCauHoiDaThem_ThemCauHoi 
ON tblCauHoi
FOR insert
AS
BEGIN
	DECLARE @maBaiThi VARCHAR(10)
	SELECT @maBaiThi = FK_MaBaiThi FROM inserted

	UPDATE tblBaiThi
	SET iSoCauHoiDaThem = iSoCauHoiDaThem + 1
	WHERE PK_MaBaiThi = @maBaiThi
END

--tạo trigger xóa câu hỏi tự động giam iSoCauHoiDaThem
create TRIGGER TG_SoLuongCauHoiDaThem_XoaCauHoi 
ON tblCauHoi
FOR delete
AS
BEGIN
	DECLARE @maBaiThi VARCHAR(10)
	SELECT @maBaiThi = FK_MaBaiThi FROM deleted

	UPDATE tblBaiThi
	SET iSoCauHoiDaThem = iSoCauHoiDaThem - 1
	WHERE PK_MaBaiThi = @maBaiThi
END


create table tblCauHoi(
	PK_MaCauHoi int identity(1,1) primary key,
	FK_MaBaiThi int,
	sCauHoi nvarchar(100),
	url_img nvarchar(100),
	DapAn_A nvarchar(100),
	dapAn_B nvarchar(100),
	dapAn_C nvarchar(100),
	dapAn_D nvarchar(100),
	dapAn nvarchar(100),

	CONSTRAINT FK_BaiThi_CauHoi
	FOREIGN KEY(FK_MaBaiThi) REFERENCES tblBaiThi(PK_MaBaiThi)
)

create table tblKetQuaThi(
		 PK_MaKetQuaThi int identity(1,1) primary key,
         FK_MaNguoiDung int,
		 FK_MaBaiThi int,
         sThoiGianBatDau nvarchar(50),
         sThoiGianKetThuc nvarchar(50),
         sThoiGianLamBai nvarchar(50),
		 fDiemSo float,

		 CONSTRAINT FK_KetQuaThi_NguoiDung
		FOREIGN KEY(FK_MaNguoiDung) REFERENCES tblNguoiDung(PK_MaNguoiDung),

		CONSTRAINT FK_KetQuaThi_BaiThi
		FOREIGN KEY(FK_MaBaiThi) REFERENCES tblBaiThi(PK_MaBaiThi)
)
create proc SP_DangNhap(@Email varchar(50), @MatKhau nvarchar(max))
as
begin
	SET NOCOUNT ON

	select * from tblNguoiDung where sEmail = @Email and sMatKhau = @MatKhau
end

create proc SP_DangKy(@Email varchar(50), @HoTen nvarchar(50), @MatKhau nvarchar(max), @status int output)
as
begin
	SET NOCOUNT ON

	if exists(select * from tblNguoiDung where sEmail = @Email)
	begin
	select @status = 0
	end
	else
	begin
	select @status = 1
	insert into tblNguoiDung values(@Email, @HoTen, @MatKhau)
	end
end 

DECLARE @s int
execute SP_DangKy 'thang11@gmail.com',N'Th?ng' , 1, @s output
PRINT @s

create proc SP_DanhSachNguoiDung
as
begin
	SET NOCOUNT ON

	select * from tblNguoiDung
end

alter proc SP_ThemBaiThi(
	@TieuDe nvarchar(50),
	@NgayTao datetime,
	@SoLuongCauHoi int,
	@ThoiGianLamBai int,
	@MoTaChung nvarchar(100),
	@MaCaThi nvarchar(50),
	@SoCauHoiDaThem int,
	@MaBaiThi int output)
as
begin
	SET NOCOUNT ON
	insert into tblBaiThi values(@TieuDe,@NgayTao,@SoLuongCauHoi,@ThoiGianLamBai,@MoTaChung,@MaCaThi, @SoCauHoiDaThem)
	SELECT @MaBaiThi = scope_identity() 
end

create proc SP_XoaBaiThi(@MaBaiThi int)
as
begin
	SET NOCOUNT ON
	delete from tblKetQuaThi
	where FK_MaBaiThi = @MaBaiThi

	delete from tblCauHoi
	where FK_MaBaiThi = @MaBaiThi

	delete from tblBaiThi 
	where PK_MaBaiThi = @MaBaiThi
end

create proc SP_TimBaiThi(@MaBaiThi int)
as
begin
	SET NOCOUNT ON
	select * from tblBaiThi
	where PK_MaBaiThi = @MaBaiThi
end

alter proc SP_DanhSachBaiThi
as
begin
	SET NOCOUNT ON
	select PK_MaBaiThi, sTieuDe, dNgayTao, iSoLuongCauHoi, iThoiGianLamBai, 
	sMoTaChung, sMaCaThi, iSoCauHoiDaThem
	from tblBaiThi
end

create proc SP_ThemCauHoi(
	@MaBaiThi int,
	@CauHoi nvarchar(100),
	@url_img nvarchar(100),
	@DapAn_A nvarchar(100),
	@dapAn_B nvarchar(100),
	@dapAn_C nvarchar(100),
	@dapAn_D nvarchar(100),
	@dapAn nvarchar(100))
as
begin
	SET NOCOUNT ON
	insert into tblCauHoi values(@MaBaiThi,
	@CauHoi,
	@url_img,
	@DapAn_A,
	@dapAn_B,
	@dapAn_C,
	@dapAn_D,
	@dapAn)
end

create proc SP_XoaCauHoi(@MaCauHoi int)
as
begin
	SET NOCOUNT ON
	delete from tblCauHoi 
	where PK_MaCauHoi = @MaCauHoi
end

create proc SP_TimCauHoi(@MaCauHoi int)
as
begin
	SET NOCOUNT ON
	Select * from tblCauHoi
	where PK_MaCauHoi = @MaCauHoi
end

create proc SP_CauHoi_BaiThi(@MaBaiThi int)
as
begin
	SET NOCOUNT ON
	select * from tblCauHoi
	where FK_MaBaiThi = @MaBaiThi
end

alter proc SP_ThemKetQuaThi(
	@MaNguoiDung int,
	@MaBaiThi int,
	@ThoiGianBatDau nvarchar(50),
	@ThoiGianKetThuc nvarchar(50),
	@ThoiGianLamBai nvarchar(50),
	@DiemSo float,
	@MaKetQuaThi int output)
as
begin
	SET NOCOUNT ON
	insert into tblKetQuaThi values(@MaNguoiDung,
	@MaBaiThi,
	@ThoiGianBatDau,
	@ThoiGianKetThuc,
	@ThoiGianLamBai,
	@DiemSo)

	SELECT @MaKetQuaThi = scope_identity()
end

alter proc SP_DanhSachKetQuaThi
as
begin
	SET NOCOUNT ON
	select PK_MaKetQuaThi, FK_MaNguoiDung, FK_MaBaiThi, sTieuDe, sHoTen, 
	sThoiGianBatDau, sThoiGianKetThuc, sThoiGianLamBai, fDiemSo, iSoLuongCauHoi
	from tblKetQuaThi
	inner join tblBaiThi on tblBaiThi.PK_MaBaiThi = tblKetQuaThi.FK_MaBaiThi
	inner join tblNguoiDung on tblNguoiDung.PK_MaNguoiDung = tblKetQuaThi.FK_MaNguoiDung
end



