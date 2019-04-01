# Write methods that return SQL queries for each part of the challeng here

def guest_with_most_appearances
  # write your query here!
  sql = <<-SQL
    SELECT *, guests.name_count FROM (select
    *, count(*) as name_count,
    rank() over (order by count(*) desc) as rank
    from guests g
    group by g.name) guests
    where guests.rank = 1
  SQL

  @db.execute(sql)
end

def most_popular_profession_per_year

  # sql = <<-SQL
  #   SELECT guests.year, guests.occupation, count(guests.occupation) FROM guests
  #   WHERE guests.year = "2015"
  #   GROUP BY guests.year, guests.occupation ORDER BY guests.year, count(guests.occupation) desc
  # SQL

  sql = <<-SQL
    SELECT guests.year, guests.occupation, max(gc) FROM (
      SELECT guests.year as yr, guests.occupation as occ, COUNT(guests.occupation) as gc FROM guests GROUP BY yr, occ)
    JOIN guests on guests.year = yr
    GROUP BY yr
  SQL

  @db.execute(sql)

end

def most_popular_profession
  sql = <<-SQL
    SELECT guests.occupation, COUNT(guests.occupation) FROM guests
    GROUP BY guests.occupation ORDER BY COUNT(occupation) DESC LIMIT 1
  SQL

  @db.execute(sql)
end

def first_name_bill
  sql = <<-SQL
    SELECT count(*) from guests WHERE name like 'Bill %'
  SQL

  @db.execute(sql)[0][0]
end

def patrick_stewart_dates
  sql = <<-SQL
    SELECT show_date FROM guests WHERE name = "Patrick Stewart"
  SQL
  @db.execute(sql)
end

def year_with_most_guests
  sql = <<-SQL
    SELECT year, MAX(gc) FROM (
      SELECT year as yr, COUNT(*) AS gc FROM guests
      GROUP BY yr)
    JOIN guests ON year = yr
    GROUP BY yr ORDER BY MAX(gc) DESC LIMIT 1
  SQL
  @db.execute(sql).first
end

def most_popular_group_per_year
  sql = <<-SQL
    SELECT year, domain, MAX(gc) FROM (
      SELECT year as yr, COUNT(domain) AS gc FROM guests
      GROUP BY yr)
    JOIN guests ON year = yr
    GROUP BY yr ORDER BY yr
  SQL
  @db.execute(sql)
end
