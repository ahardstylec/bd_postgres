class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :author

  def self.bulk_insert(insert_multifier=1)
    puts "insert with #{10000*insert_multifier} records"
    Benchmark.bm do |bm|
      bm.report do
        (0..100).each do |author_nummer|
          author = Author.create(name: "author #{author_nummer}", email: "author_email_#{author_nummer}@author_email.de")
          (1..10000*insert_multifier).each do |index|
            question= Question.create(author_id: author.id, question: "frage #{index}")
            (1..5).each do |anwsernum|
              Answer.create(question_id: question.id, answer: "bla", correct: (anwsernum%5 == 0))
            end
          end
        end
      end
    end
  end

  def self.sql_pure_inserts(insert_multifier)
    puts "pure sql insert with #{10000*insert_multifier} records"
    Benchmark.bm  do |bm|
      # joining an array of strings
      bm.report do
        questions =[]
        authors = []
        inserts=[]
        Author.transaction do
          (0..100).map do |author_nummer|
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
            inserts.push "(#{(anwsernum%5 == 0)}, 'bla antwort', #{question.id})"
          end
        end
        sql = "INSERT INTO answers (`correct`,  `answer`, `question_id`) VALUES #{inserts.join(", ")}"
        ActiveRecord::Base.connection.execute sql
        nil
      end
    end
  end
end
