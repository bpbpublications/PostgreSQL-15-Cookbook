CREATE OR REPLACE FUNCTION encrypt_db_data(plaintext text)
RETURNS bytea AS $$
BEGIN
    RETURN pgp_sym_encrypt(plaintext, 'secret-key');
END;
$$ LANGUAGE plpgsql;