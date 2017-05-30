--Sys--
Grant DBMS_CRYPTO to TBMG

--Alter table

ALTER TABLE NHANVIEN_162_213_340
ADD 
(
  signature RAW(32000)
);


CREATE OR REPLACE FUNCTION create_signature(
                                       in_message IN VARCHAR2,
                                        in_private_key IN CLOB )
RETURN raw DETERMINISTIC
IS
  signature RAW(32000);
BEGIN
  signature := ORA_RSA.SIGN(message => UTL_I18N.STRING_TO_RAW(in_message, 'AL32UTF8'),
        private_key => UTL_RAW.cast_to_raw(in_private_key),
        private_key_password => '',
        hash => ora_rsa.hash_sha256);
  RETURN signature;
END;

 
CREATE OR REPLACE FUNCTION verify_signature(in_message IN VARCHAR2, in_signature IN RAW, in_public_key IN CLOB)
RETURN varchar2 DETERMINISTIC
IS
  signature_check_result PLS_INTEGER;
BEGIN
	IF in_signature IS NULL THEN
		RETURN 'Signature cannot be verified.';
	END IF; 
    signature_check_result := ORA_RSA.VERIFY(message => UTL_I18N.STRING_TO_RAW(in_message, 'AL32UTF8'), 
        signature => in_signature, 
        public_key => UTL_RAW.cast_to_raw(in_public_key),
        HASH => ORA_RSA.HASH_SHA256);
 
    IF signature_check_result = 1 THEN
       RETURN 'Signature verification passed.'; 
    ELSE
       RETURN 'Signature cannot be verified.'; 
    END IF; 
END;