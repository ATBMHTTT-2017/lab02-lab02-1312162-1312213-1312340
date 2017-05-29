




--Sys--
Grant DBMS_CRYPTO to TBMG

--Alter table
/*
alter table 
   CHITIEU_162_213_340
modify 
( 
   soTien    RAW(16)
);



INSERT INTO CHITIEU_162_213_340 VALUES ('CT001','Chi Tieu 1', '000', 'DA001' );
INSERT INTO CHITIEU_162_213_340 VALUES ('CT002','Chi Tieu 2', '000', 'DA002' );
INSERT INTO CHITIEU_162_213_340 VALUES ('CT003','Chi Tieu 3', '000', 'DA003' );
INSERT INTO CHITIEU_162_213_340 VALUES ('CT004','Chi Tieu 4', '000', 'DA004' );
INSERT INTO CHITIEU_162_213_340 VALUES ('CT005','Chi Tieu 5', '000', 'DA005' );
*/

--test--
/*
update  CHITIEU_162_213_340
Set soTien = UTL_RAW.cast_to_raw('2000')
where MACHITIEU = 'CT002'

select * from CHITIEU_162_213_340

select * from Chitieu_for_TDA;

*/

CREATE OR REPLACE VIEW Chitieu_for_TDA AS
select MACHITIEU,TENCHITIEU,toolkit.decrypt(SOTIEN) AS SoTien , DUAN from CHITIEU_162_213_340;



Grant insert,delete,update,select on CHITIEU_162_213_340 to TRUONGDUAN;

Grant select on Chitieu_for_TDA to TRUONGDUAN with Grant option;

select tbmg.toolkit.decrypt(SOTIEN) as tien from CHITIEU_162_213_340;

--Toolkit for encrypt and decrypt
CREATE OR REPLACE PACKAGE toolkit AS

  FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW;
  
  FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2;
  
  
  
END toolkit;

--Toolkit body
CREATE OR REPLACE PACKAGE BODY toolkit AS

  g_key     RAW(32767)  := UTL_RAW.cast_to_raw('12345678');
  g_pad_chr VARCHAR2(1) := '~';

PROCEDURE padstring (p_text  IN OUT  VARCHAR2);

  FUNCTION encrypt (p_text  IN  VARCHAR2) RETURN RAW IS

    l_text       VARCHAR2(32767) := p_text;
    l_encrypted  RAW(32767);
  BEGIN
    padstring(l_text);
    DBMS_OBFUSCATION_TOOLKIT.desencrypt(input          => UTL_RAW.cast_to_raw(l_text),
                                        key            => g_key,
                                        encrypted_data => l_encrypted);
    RETURN l_encrypted;
  END;
 

  FUNCTION decrypt (p_raw  IN  RAW) RETURN VARCHAR2 IS

    l_decrypted  VARCHAR2(32767);
  BEGIN
    DBMS_OBFUSCATION_TOOLKIT.desdecrypt(input => p_raw,
                                        key   => g_key,
                                        decrypted_data => l_decrypted);
                                        
    RETURN RTrim(UTL_RAW.cast_to_varchar2(l_decrypted), g_pad_chr);
  END;

  PROCEDURE padstring (p_text  IN OUT  VARCHAR2) IS

    l_units  NUMBER;
  BEGIN
    IF LENGTH(p_text) MOD 8 > 0 THEN
      l_units := TRUNC(LENGTH(p_text)/8) + 1;
      p_text  := RPAD(p_text, l_units * 8, g_pad_chr);
    END IF;
  END;

END toolkit;

--Trigger activate Toolkit
CREATE OR REPLACE TRIGGER Chitieu_TDA
BEFORE INSERT on CHITIEU_162_213_340
FOR EACH ROW
DECLARE
BEGIN
  :new.soTien := toolkit.encrypt(UTL_RAW.cast_to_varchar2(:new.soTien));
END;
CREATE OR REPLACE TRIGGER Chitieu_TDA2
BEFORE UPDATE ON CHITIEU_162_213_340
FOR EACH ROW
DECLARE
BEGIN
  :new.soTien := toolkit.encrypt(UTL_RAW.cast_to_varchar2(:new.soTien));
END;