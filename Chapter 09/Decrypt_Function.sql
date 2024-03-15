CREATE OR REPLACE FUNCTION decrypt_db_data (ciphertext text)
RETURNS text AS $$
BEGIN
    RETURN pgp_sym_decrypt(cast(ciphertext as bytea), 'secret-key');
END;
$$ LANGUAGE plpgsql;