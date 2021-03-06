
--Connect as SYS

--De tao users ma khong can container database(12c)
--alter session set "_ORACLE_SCRIPT"=true;





-- tbmg se la user co quyen tren table de thuc quyen cap VPD.

--CREATE USER tbmg IDENTIFIED BY 123456;
CREATE USER NV001 IDENTIFIED BY 123456 ;
CREATE USER NV002 IDENTIFIED BY 123456 ;
CREATE USER NV003 IDENTIFIED BY 123456 ;
CREATE USER NV004 IDENTIFIED BY 123456 ;
CREATE USER NV005 IDENTIFIED BY 123456 ;
CREATE USER NV006 IDENTIFIED BY 123456 ;
CREATE USER NV007 IDENTIFIED BY 123456 ;
CREATE USER NV008 IDENTIFIED BY 123456 ;
CREATE USER NV009 IDENTIFIED BY 123456 ;
CREATE USER NV010 IDENTIFIED BY 123456 ;
CREATE USER NV000 IDENTIFIED BY 123456 ;


-- quyen cho TBMG  (SYS)( da tao o ban table)
--GRANT CREATE SESSION TO tbmg;
--GRANT dba to tbmg;
--GRANT EXECUTE ON DBMS_RLS TO tbmg;
--GRANT CREATE PROCEDURE TO tbmg;
--GRANT exempt access policy to tbmg;
--GRANT create any content to tbmg;

-- cap quyen dang nhap cho cac user
GRANT CONNECT,CREATE SESSION,resource,create view TO NV001,NV002,NV003,NV004,NV005,NV006,NV007,NV008,NV009,NV010,NV000;
--Dang connect voi Sys nen sys se tao role.
CREATE ROLE NHANVIEN ;
CREATE ROLE TRUONGPHONG;
CREATE ROLE TRUONGDUAN ;
CREATE ROLE TRUONGCHINHANH ;
CREATE ROLE GIAMDOC;

--Nhóm Nhân Viên:
GRANT NHANVIEN TO NV006;
GRANT NHANVIEN TO NV007;
GRANT NHANVIEN TO NV008;
GRANT NHANVIEN TO NV009;
GRANT NHANVIEN TO NV010;


--Nhóm Trý?ng Ph?ng:
GRANT TRUONGPHONG TO NV001;
GRANT TRUONGPHONG TO NV002;
GRANT TRUONGPHONG TO NV003;
GRANT TRUONGPHONG TO NV004;
GRANT TRUONGPHONG TO NV005;
--Nhóm Trý?ng DUAN:
GRANT TRUONGDUAN TO NV001;
GRANT TRUONGDUAN TO NV002;
GRANT TRUONGDUAN TO NV003;
GRANT TRUONGDUAN TO NV004;
GRANT TRUONGDUAN TO NV005;
--Nhóm Trý?ng CHi Nhánh:
GRANT TRUONGCHINHANH TO NV001;
GRANT TRUONGCHINHANH TO NV002;
GRANT TRUONGCHINHANH TO NV003;
GRANT TRUONGCHINHANH TO NV004;
GRANT TRUONGCHINHANH TO NV005;

--Giam Doc
GRANT GIAMDOC TO NV000;
