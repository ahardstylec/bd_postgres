namespace :db_benchmark do

  def trunc_tables
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE questions")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE answers")
  end

  task run: :environment do
    trunc_tables
    # base_1 = Question.bulk_insert(1)
    # Question.select_from_author
    # Question.select_from_author
    # Question.select_from_author
    # Question.select_count
    # Question.select_count
    # Question.select_count
    # STDOUT.flush
    # trunc_tables
    base_5 = Question.bulk_insert(5)
    Question.select_count
    Question.select_count
    Question.select_count
    Question.select_from_author
    Question.select_from_author
    Question.select_from_author
    STDOUT.flush
    # trunc_tables
    # base_10 = Question.bulk_insert(10)
    # Question.select_from_author
    # Question.select_from_author
    # Question.select_from_author
    # STDOUT.flush
    # trunc_tables
  end

end
