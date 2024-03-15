# Create Audit-log tracking Table
 CREATE TABLE audit_log_tracker (
   id SERIAL PRIMARY KEY,
   user_id VARCHAR(50) NOT NULL,
   table_name VARCHAR(50) NOT NULL,
   operation_type CHAR(1) NOT NULL,
   old_value JSONB,
   new_value JSONB,
   created_at TIMESTAMP NOT NULL DEFAULT NOW()
 );