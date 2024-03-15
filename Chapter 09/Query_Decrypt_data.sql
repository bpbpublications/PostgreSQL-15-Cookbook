SELECT id, name, email, decrypt_db_data(credit_card) AS credit_card, decrypt_db_da
ta(ssn) AS ssn FROM customer_info;