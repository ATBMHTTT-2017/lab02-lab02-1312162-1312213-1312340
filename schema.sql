-- tbmg se la user co quyen tren table de thuc quyen cap VPD.

CREATE USER tbmg IDENTIFIED BY 123456;
GRANT CREATE SESSION TO tbmg;
GRANT dba to tbmg;
GRANT EXECUTE ON DBMS_RLS TO tbmg;
GRANT CREATE PROCEDURE TO tbmg;
GRANT exempt access policy to tbmg;
GRANT CREATE ANY CONTEXT to tbmg;

connect tbmg/123456;

-- T?o CSDL:
Create table NhanVien_162_213_340(
  maNV varchar2(5), 
  hoTen varchar2(50),
  diaChi varchar2(100),
  dienThoai varchar2(20),
  email varchar2(30),
  maPhong varchar2(5),
  chiNhanh varchar2(5),
  luong number,
  
  Primary Key (maNV)
);

Create table ChiNhanh_162_213_340(
  maCN varchar2(5), 
  tenCN varchar2(50),
  truongChiNhanh varchar2(5),

  Primary Key (maCN)
);

Create table PhongBan_162_213_340 (
  maPhong varchar2(5),
  tenPhong varchar2(50),
  truongPhong varchar2(5),
  ngayNhanChuc date,
  soNhanVien number,
  chiNhanh varchar2(5),
  
  Primary Key (maPhong)
);

Create table DuAn_162_213_340(
  maDA varchar2(5),
  tenDA varchar2(50),
  kinhphi number,
  phongChuTri varchar2(5),
  truongDA varchar2(5),
  
  Primary Key (maDA)
);

Create table ChiTieu_162_213_340(
  maChiTieu varchar2(5),
  tenChiTieu varchar2(50),
  soTien number,
  duAn varchar2(5),
  
  Primary Key (maChiTieu)
);

Create table PhanCong_162_213_340(
  maNV varchar2(5),
  duAn varchar2(5),
  vaiTro varchar2(50),
  phuCap number,
  
  Primary Key (maNV,duAn)
);

Alter table NHANVIEN_162_213_340 add foreign key (maPhong) references PhongBan_162_213_340(maPhong);
Alter table NHANVIEN_162_213_340 add foreign key (chiNhanh) references ChiNhanh_162_213_340(maCN);
Alter table ChiNhanh_162_213_340 add foreign key (truongChiNhanh) references NHANVIEN_162_213_340(maNV);
Alter table PhongBan_162_213_340 add foreign key (truongPhong) references NHANVIEN_162_213_340(maNV);
Alter table PhongBan_162_213_340 add foreign key (chiNhanh) references ChiNhanh_162_213_340(maCN);
Alter table DuAn_162_213_340 add foreign key (phongChuTri) references PhongBan_162_213_340(maPhong);
Alter table DuAn_162_213_340 add foreign key (truongDA) references NHANVIEN_162_213_340(maNV);
Alter table ChiTieu_162_213_340 add foreign key (duAn) references DuAn_162_213_340(maDA);
Alter table PhanCong_162_213_340 add foreign key (maNV) references NHANVIEN_162_213_340(maNV);
Alter table PhanCong_162_213_340 add foreign key (duAn) references DuAn_162_213_340(maDA);