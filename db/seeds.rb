# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  path = Rails.root.join('vendor', 'seeds')
  
  connection = ActiveRecord::Base.connection

  # Truncate all tables
  connection.tables.each do |table|
    connection.execute("SET FOREIGN_KEY_CHECKS = 0;")
    connection.execute("TRUNCATE #{table}") unless table == "schema_migrations"
    connection.execute("SET FOREIGN_KEY_CHECKS = 1;")
  end

  # Find .sql files in path
  Dir.entries(path).each do |file|

    unless file == '.' or file == '..' or file == '_'

      p "Inserting from #{file}..."

      sql = File.read("#{path}/#{file}")
      statements = sql.split(/;$/)
      statements.pop

      ActiveRecord::Base.transaction do
        statements.each do |statement|
          connection.execute(statement)
        end
      end
    end
  end
end