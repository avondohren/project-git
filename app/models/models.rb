ActiveRecord::Base.establish_connection(
:adapter => 'sqlite3',
:database => (ENV['RACK_ENV'] == "test") ? "./app/data/university.test" : "./app/data/university"
)

ActiveRecord::Base.logger = Logger.new(STDERR)          #sends logs to terminal

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'students'
    create_table :students do |table|
      #id - autoincrement integer key is created be default
      table.column :fname,       :string
      table.column :lname,       :string
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'teachers'
    create_table :teachers do |table|
      #id - autoincrement integer key is created be default
      table.column :fname,       :string
      table.column :lname,       :string
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'rosters'
    create_table :rosters do |table|
      table.column :klass_id,   :integer
      table.column :student_id,    :integer
      table.column :grade,      :integer
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'klasses'
    create_table :klasses do |table|
      table.column :term_id,    :integer
      table.column :name,       :string
      table.column :teacher_id,    :integer
    end
  end
  
  unless ActiveRecord::Base.connection.tables.include? 'terms'
    create_table :terms do |table|
      table.column :name,       :string
    end
  end  
end


class Teacher < ActiveRecord::Base
  belongs_to :klass
  
  def name 
    fname + " " + lname
  end
end

class Student < ActiveRecord::Base
  belongs_to :roster
  
  def name 
    fname + " " + lname
  end
end

class Klass < ActiveRecord::Base
  belongs_to :term
  belongs_to :roster
  has_one :teacher
end

class Roster < ActiveRecord::Base
  has_many :klasses
  has_many :students
end

class Term < ActiveRecord::Base
  has_many :klasses
end
