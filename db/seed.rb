# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.
require 'csv'


@table = CSV.parse(File.open("daily_show_guests.csv"), headers:true)

def insert_by_row(row)
  sql = <<-SQL
    INSERT INTO guests (year, occupation, show_date, domain, name)
    VALUES (?, ?, ?, ?, ?)
  SQL
  # db.execute(sql, new_pokemon.name, new_pokemon.type)
  @db.execute(sql, row[0], row[1], row[2], row[3], row[4])
end

@table.each { |row| insert_by_row(row) }
