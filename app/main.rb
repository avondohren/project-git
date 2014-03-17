require 'sinatra/base'
require 'active_record'
require 'logger'
require 'pry'
require_relative './controllers/functions'

class UniversitySystem < Sinatra::Base
  helpers do
  end
  
  before do
  end
  
  get "/" do
    erb :home
  end
  
  get "/add/term" do
    erb :add_term
  end
  
  post "/add/term" do
    name = params[:name]
    new_term = Term.create({:name => name})
    
    redirect to("/term/#{new_term.id}")
  end
  
  get "/add/student" do
    erb :add_student
  end
  
  post "/add/student" do
    fname = params[:fname]
    lname = params[:lname]
    
    new_student = Student.create({:fname => fname, :lname => lname})
    
    redirect to("/student/#{new_student.id}")
  end
  
  get "/add/teacher" do
    erb :add_teacher
  end
  
  post "/add/teacher" do
    fname = params[:fname]
    lname = params[:lname]
    
    new_teacher = Teacher.create({:fname => fname, :lname => lname})
    
    redirect to("/teacher/#{new_teacher.id}")
  end
  
  get "/list/term" do
    @terms = Term.all
    erb :list_term
  end
  
  get "/term/:id" do
    @term = Term.find(params[:id])
    erb :term
  end

  get "/student/:id" do
    @student = Student.find_by_id(params[:id])
    erb :student
  end

  get "/teacher/:id" do
    @teacher = Teacher.find_by_id(params[:id])
    erb :teacher
  end

  get "/list/classes" do
    @klasses = Klass.all
    
    erb :list_klasses
  end
  
  get "/list/students" do
    @students = Student.all
    erb :list_students
  end

  get "/list/teachers" do
    @teachers = Teacher.all
    erb :list_teachers
  end

  get "/add/class" do
    erb :add_klass
  end
  
  post "/add/class" do
    new_klass = Klass.create({
      :term_id => params[:term_id],
      :name => params[:name],
      :teacher_id => params[:teacher_id]
    })
    
    redirect to("/class/#{new_klass.id}")
  end
  
  get "/class/:id" do
    @klass = Klass.find(params[:id])
    erb :klass
  end
  
  get "/enroll" do
    @students = Student.all
    @klasses = Klass.all
    
    erb :enroll
  end
  
  post "/enroll" do
    klass_id = params[:klass_id].to_i
    student_id = params[:student_id].to_i
    
    new_roster = Roster.create({
      :klass_id => klass_id,
      :student_id => student_id
    })
    
    redirect to("/class/#{klass_id}")
end