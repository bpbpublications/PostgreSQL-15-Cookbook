# Install Package Manager for Perl module
yum install perl-CPAN

# Extract the DBIx::Safe downloaded archive

tar -xzf DBIx-Safe-1.2.5.tar.gz
# Change to the DBIx-Safe-1.2.5 directory once extracted
cd DBIx-Safe-1.2.5
# Build and install the module using make
perl Makefile.PL
make
make install

# Extract the Bucardo downloaded archive
tar -xzf Bucardo-5.6.0.tar.gz
# Change to the Bucardo-5.6.0 directory once extracted
cd Bucardo-5.6.0
# Build and install the module using make
perl Makefile.PL
make
make install

# Install Perl procedural language 
yum localinstall -y postgresql15-plperl-15.1-1PGDG.rhel9.x86_64.rpm

# Initialize the Bucardo database schema
bucardo install

# Start bucardo service
bucardo start
# Check bucardo service status
bucardo status

# Add first primary node
bucardo add database pg1 dbname=postgres host=192.168.187.133 port=5432 user=bucardo

# Add second primary node
bucardo add database pg2 dbname=postgres host=192.168.187.134 port=5432 user=bucardo

# Add database group on first primary node
bucardo add dbgroup pg_dbgroup pg1:source pg2:source

# Add tables for synchronization on first primary node
bucardo add all tables db=pg1 –herd=relgrp

# Add sequences for synchronization on first primary node
bucardo add all sequences db=pg1 –herd=relgrp


# Add sync configuration on first primary node
bucardo add sync sync1 relgroup=relgrp dbs=pg1:source,pg2:source


# Add first primary node
bucardo add database pg1 dbname=postgres host=192.168.187.133 port=5432 user=bucardo

# Add second primary node
bucardo add database pg2 dbname=postgres host=192.168.187.134 port=5432 user=bucardo

# Add database group on second primary node
bucardo add dbgroup pg_dbgroup pg1:source pg2:source


# Add tables for synchronization on first primary node
bucardo add all tables db=pg1 –herd=relgrp

# Add sequences for synchronization on first primary node
bucardo add all sequences db=pg1 –herd=relgrp


# Add sync configuration on first primary node
bucardo add sync sync1 relgroup=relgrp dbs=pg1:source,pg2:source

# Restart bucardo demon on both the primary node
bucardo restart

# Connect to the 1 st  primary node
psql -h <1st_primary_node_ip> -p <1st_primary_node_port> -U <bucardo_user> -d <db_name>

# Create a table &quot;test_table&quot; on the first primary node
create table test_table (id serial primary key, name text);

# Insert the data on table &quot;test_table&quot; on the first primary node
insert into test_table (name) values ('John'), ('Jane'), ('Bob');

# Connect to the Second primary node
psql -h <2nd_primary_node_ip> -p <2nd_primary_node_port> -U <bucardo_user> -d <db_name>

# Create a table &quot;test_table&quot; on the first primary node
create table test_table (id serial primary key, name text);

# Add tables for synchronization on first primary node
bucardo add all tables db=pg1 --herd=relgrp

# Add sync configuration on both primary node
bucardo add sync sync2 relgroup=relgrp dbs=pg1:source,pg2:source


# Restart bucardo demon on both the primary node
bucardo restart

# Connect to the Second primary node
psql -h <2nd_primary_node_ip> -p <2nd_primary_node_port> -U <bucardo_user> -d <db_name>

# Verify the populated from second primary node
Select * from test_table;


