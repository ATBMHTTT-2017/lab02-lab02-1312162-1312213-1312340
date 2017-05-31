--Sys--
Grant DBMS_CRYPTO to TBMG

--Alter table

ALTER TABLE NHANVIEN_162_213_340
ADD 
(
  signature RAW(31100)
);

ALTER TABLE NHANVIEN_162_213_340
ADD 
(
  luong_encrypted RAW(1100),
  key RAW(128)
);


CREATE OR REPLACE PROCEDURE DC_Luong
as
luong_raw RAW(1100);
output_string VARCHAR2(100);
luong_decrypted_raw RAW(1100);
key_bytes_raw RAW(32);
encryption_type PLS_INTEGER:=DBMS_CRYPTO.ENCRYPT_AES256+DBMS_CRYPTO.CHAIN_CBC+ DBMS_CRYPTO.PAD_PKCS5;
begin
select luong_encrypted into luong_raw  from NhanVien where maNV=USER;
select key into key_bytes_raw from NhanVien where maNV=USER;
luong_decrypted_raw:=DBMS_CRYPTO.DECRYPT
  (src=>luong_raw,
  typ=>encryption_type,
  key=>key_bytes_raw);
  output_string:=UTL_I18N.RAW_TO_CHAR(luong_decrypted_raw,'AL32UTF8');
DBMS_OUTPUT.PUT_LINE('Luong:  '||output_string);
end;


 
CREATE OR REPLACE PROCEDURE EC_Luong (in_maNV varchar2)
AS
in_luong int;
encrypted_raw RAW(1100);
input_string VARCHAR2(100);
num_key_bytes NUMBER:=256/8;
key_bytes_raw RAW(32);
encryption_type PLS_INTEGER:=DBMS_CRYPTO.ENCRYPT_AES256+DBMS_CRYPTO.CHAIN_CBC+ DBMS_CRYPTO.PAD_PKCS5;
begin
select TO_CHAR(luong) into input_string from NHANVIEN_162_213_340 where maNV=in_maNV;
key_bytes_raw:=DBMS_CRYPTO.RANDOMBYTES (num_key_bytes);
encrypted_raw:=DBMS_CRYPTO.ENCRYPT
(src=>UTL_I18N.STRING_TO_RAW(input_string, 'AL32UTF8'),
  typ=>encryption_type,
  key=>key_bytes_raw);
update NHANVIEN_162_213_340 SET luong_encrypted=encrypted_raw where maNV=in_maNV;
update NHANVIEN_162_213_340 SET key=key_bytes_raw where maNV=in_maNV;
end;
