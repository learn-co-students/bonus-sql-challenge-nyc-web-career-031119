class SQLRunner


  def initialize(db)
    @db = db
  end

  def execute_schema_migration_sql
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS guests(
        id INTEGER PRIMARY KEY,
        year INTEGER,
        occupation TEXT,
        show_date TEXT,
        domain TEXT,
        name TEXT)
    SQL
    @db.execute(sql)
  end

  def execute_sql(sql)
     sql.scan(/[^;]*;/m).each { |line| @db.execute(line) } unless sql.empty?
  end

end
