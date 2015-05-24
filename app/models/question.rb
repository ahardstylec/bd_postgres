class Question < ActiveRecord::Base
  has_many :answers

  def self.bulk_insert(insert_multifier=1)
    puts "insert with #{100*10000*insert_multifier} records"
    question_id= 1
    puts bench =Benchmark.measure {
      (1..100).each do |author_nummer|
        sql_questions_map=[]
        sql_answers_map=[]
        sql_questions="INSERT INTO questions (id, question, author_name, author_email) VALUES "
        sql_answers= "INSERT INTO answers (question_id, answer, correct) VALUES "
        (1..(10000*insert_multifier)).each do |index|
          sql_questions_map << "('#{question_id}', 'author #{author_nummer}', 'frage #{question_id}', 'author_email_#{author_nummer}@author_email.de')"
          (1..5).each do |anwsernum|
            sql_answers_map << sprintf(" ('%s', '%s', '%s')", question_id, "answer soundo", "#{(anwsernum%5 == 0)}")
          end
          question_id+=1
        end
        self.connection.execute("#{sql_questions} #{sql_questions_map.join(',')};")
        self.connection.execute("#{sql_answers} #{sql_answers_map.join(',')};")
      end
    }
    bench
  end

  def self.select_from_author
    questions=nil
    bench= Benchmark.measure { questions = Question.where(author_email: "author_email_1@author_email.de").all}
    puts "select from author 1: #{questions.count}"
    puts bench
  end

  def self.select_count
    count = nil
    bench = Benchmark.measure { count = Question.count }
    puts "select count all questions: #{count}"
    puts bench
  end

end
