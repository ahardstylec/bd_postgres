class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :author

  def self.bulk_insert(insert_multifier=1)
    puts "insert with #{100*10000*insert_multifier} records"
    puts bench =Benchmark.measure {
      (1..100).each do |author_nummer|
        author = Author.create(name: "author #{author_nummer}", email: "author_email_#{author_nummer}@author_email.de")
        (1..10000*insert_multifier).each do |index|
          question= Question.create(author_id: author.id, question: "frage #{index}")
          (1..5).each do |anwsernum|
            Answer.create(question_id: question.id, answer: "bla", correct: (anwsernum%5 == 0))
          end
        end
      end
    }
    bench
  end

  def self.select_from_author
    questions=nil
    author= Author.find_by_name("author 1")
    bench= Benchmark.measure { questions = author.questions.all }
    puts "select from author 1: #{questions.count}"
    puts bench
  end

  def self.select_count
    count = nil
    bench = Benchmark.measure { count = Question.count }
    puts "select count all questions: #{count}"
    puts bench
  end

  def self.sql_pure_inserts(insert_multifier)
    puts "pure sql insert with #{100*10000*insert_multifier} records"
    puts bench= Benchmark.measure {
      questions =[]
      authors = []
      Author.transaction do
        (1..100).map do |author_nummer|
          authors<< Author.create(name: "author #{author_nummer}", email: "author_email_#{author_nummer}@author_email.de")
        end
      end
      Question.transaction do
        authors.each do |author|
          (1..10000*insert_multifier).each do |index|
            questions<<Question.create(author_id: author.id, question: "frage #{index}")
          end
        end
      end
      questions.each do |question|
        (1..5).each do |anwsernum|
          Answer.create(question_id: question.id, answer: 'bla antwort', correct: (anwsernum%5 == 0))
        end
      end
      nil
      }
    bench
  end
end
