require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "cassandra insert test" do
    Benchmark.bm do |bm|
      # joining an array of strings
      puts "Create 1 Million Question Records With 4 Answers"
      bm.report do
        questions =[]
        authors = []
        (0..100).each do |author_nummer|
          authors.push(Author.new(name: "author #{author_nummer}", email: "author_email_#{author_nummer}@author_email.de"))
        end
        Author.transaction do
          authors.each(&:save)
          end
        authors.each do |author|
          (1..10000).each do |index|
            questions<<Question.new(author_id: author.id, question: "frage #{index}")
          end
        end

        Question.transaction do
          questions.each(&:save)
        end
        questions.each do |question|
          (1..5).each do |anwsernum|
            Answer.new(question_id: question.id, answer: "bla", correct: (anwsernum%5 == 0))
          end
        end
      end
    end
    end
end
