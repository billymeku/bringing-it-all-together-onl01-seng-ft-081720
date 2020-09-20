class Dog 
<<<<<<< HEAD
  attr_accessor :id, :name, :breed
 
  
   def initialize(id: nil,name:, breed:)
     @id = id
    @name = name
    @breed = breed 
  end
  
  def self.create_table
        sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
    SQL
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table
    sql =  "DROP TABLE IF EXISTS dogs"
    DB[:conn].execute(sql)
  end 
  
  def save
    if self.id
    self.update
    else
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      end
      return self 
  end 
  
  def self.create(name:, breed:)
    dog= Dog.new(name: name, breed: breed)
    dog.save
    dog
  end
  
  
  def self.new_from_db(row)
     dog = Dog.new(name: row[1],breed: row[2],id: row[0])
  end
  
  def self.find_by_id(id)
    sql = <<-SQL
      SELECT *
      FROM dogs 
      WHERE id = ?
    SQL
   DB[:conn].execute(sql,id).map do |row|
     self.new_from_db(row)
    end.first 
  end 
  
 
  def self.find_or_create_by(name:, breed:)
    sql = <<-SQL
      SELECT *  FROM dogs WHERE name = ? AND breed = ? LIMIT 1
    SQL
    dog =DB[:conn].execute(sql,name,breed)
      if !dog.empty?
        dog_data = dog[0]
        dog = Dog.new(id: dog_data[0], name: dog_data[1],breed: dog_data[2])
      else
        dog = self.create(name: name, breed: breed)
      end
    dog 
  end
  
  
  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM dogs 
      WHERE name = ?
      LIMIT 1
    SQL
 
    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end
  
  def update
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end 

end 
=======

attr_accessor :name, :breed, :id

    def initialize (id: nil, name:, breed:)
        @name = name
        @breed = breed
        @id = id
    end  
end
  # attr_accessor :id, :name, :breed
 
  
  # def initialize(id = nil, name:, breed:)
  #   @id = id
  #   @name = name
  #   @breed = breed 
  # end
  
#   def self.create_table
#         sql =  <<-SQL
#       CREATE TABLE IF NOT EXISTS dogs (
#         id INTEGER PRIMARY KEY,
#         name TEXT,
#         breed TEXT
#         )
#     SQL
#     DB[:conn].execute(sql)
#   end 
  
#   def self.drop_table
#     sql =  "DROP TABLE IF EXISTS dogs"
#     DB[:conn].execute(sql)
#   end 
  
#   def save
#     if self.id
#     self.update
#     else
#     sql = <<-SQL
#       INSERT INTO dogs (name, breed)
#       VALUES (?, ?)
#     SQL
#     DB[:conn].execute(sql, self.name, self.breed)
#     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
#       end
#   end 
  
#   def self.create(name:, breed:)
#     dog= Dog.new(name, breed)
#     dog.save
#     dog
#   end
  
#   # def self.new_from_db(row)
#   # new_student = Student.new  
#   # new_student.id = row[0]
#   # new_student.name =  row[1]
#   # new_student.grade = row[2]
#   # new_student  
#   # end
  
#   # def self.find_by_id(id)
#   #   sql = "SELECT * FROM dogs WHERE id = ?"
#   #   result = DB[:conn].execute(sql, id)[0]
#   #   Song.new(result[0], result[1], result[2])
#   # end
 
#   # def update
#   #   sql = "UPDATE songs SET name = ?, breed = ? WHERE id = ?"
#   #   DB[:conn].execute(sql, self.name, self.breed, self.id)
#   # end
#   # def self.find_or_create_by(name:, album:)
#   #   song = DB[:conn].execute("SELECT * FROM songs WHERE name = ? AND album = ?", name, album)
#   #   if !song.empty?
#   #     song_data = song[0]
#   #     song = Song.new(song_data[0], song_data[1], song_data[2])
#   #   else
#   #     song = self.create(name: name, album: album)
#   #   end
#   #   song
#   # end
  
#   # def self.find_by_name(name)
#   #   sql = <<-SQL
#   #     SELECT *
#   #     FROM students
#   #     WHERE name = ?
#   #     LIMIT 1
#   #   SQL
 
#   #   DB[:conn].execute(sql, name).map do |row|
#   #     self.new_from_db(row)
#   #   end.first
#   # end
  
#   def update
#     sql = "UPDATE songs SET name = ?, album = ? WHERE id = ?"
#     DB[:conn].execute(sql, self.name, self.breed, self.id)
#   end
# end 
>>>>>>> b9634257391264d0ca7ff04a6278c51314cf91c0
