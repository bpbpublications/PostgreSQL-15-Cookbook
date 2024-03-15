# Create trigger function for tracking change
CREATE OR REPLACE FUNCTION audit_log_tracker_trigger() RETURNS TRIGGER AS $$
DECLARE
  operation_type CHAR(1);
BEGIN
  IF TG_OP = 'INSERT' THEN
    operation_type := 'I';
  ELSIF TG_OP = 'UPDATE' THEN
    operation_type := 'U';
  ELSIF TG_OP = 'DELETE' THEN
    operation_type := 'D';
  ELSE
    RAISE EXCEPTION 'Unknown TG_OP: "%". Should be INSERT, UPDATE, or DELETE.', TG
_OP;
  END IF;
  INSERT INTO audit_log_tracker (user_id, table_name, operation_type, old_value, n
ew_value)
  VALUES (CURRENT_USER, TG_TABLE_NAME, operation_type, to_jsonb(old), to_jsonb(new
));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;