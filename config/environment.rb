require 'bundler'
Bundler.require

require_relative "sql_runner"

# Setup a DB connection here
@db = SQLite3::Database.new('db/daily_show_guests.db')
@db.execute("DROP TABLE IF EXISTS guests;")
@db.execute("DROP TABLE IF EXISTS hosts;")
@sql_runner = SQLRunner.new(@db)
@sql_runner.execute_schema_migration_sql

require_relative "../db/seed"
require_relative '../lib/queries'
