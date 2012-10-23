require 'sqlite3'

class DB

def self.create_table
  @db = SQLite3::Database.open( "stackseekr.db" )
  sql = <<SQL
  CREATE table jobstable,
  ( id INTEGER PRIMARY KEY, 
  job_title TEXT,
  company_name TEXT,
  location TEXT,
  terms TEXT,
  job_description TEXT,
  skills TEXT,
  company_description TEXT
  );
SQL

@db.execute sql

@db
end

def self.drop_table
  @db = SQLite3::Database.open( "stackseekr.db")
  sql = <<SQL
  DROP table stackjobs;
SQL

@db.execute sql

end

end

DB.create_table 

