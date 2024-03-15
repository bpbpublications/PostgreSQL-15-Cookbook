# Example scenario insert query
DO $$
BEGIN
   FOR r IN 1..1000 LOOP
      INSERT INTO pgbook (id) VALUES (r);

   END LOOP;
END;
$$;