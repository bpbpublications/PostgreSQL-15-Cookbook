# Function that encrypt data
CREATE OR REPLACE FUNCTION encrypt_data(data TEXT) RETURNS BYTEA AS $$
DECLARE
   key TEXT := 'secret-key';
BEGIN
   RETURN pgp_sym_encrypt(data, key);
END;
$$ LANGUAGE plpgsql;
# Function that decrypt data
CREATE OR REPLACE FUNCTION decrypt_data(data BYTEA) RETURNS TEXT AS $$

DECLARE
   key TEXT := 'secret-key';
BEGIN
   RETURN pgp_sym_decrypt(data, key);
END;
$$ LANGUAGE plpgsql;