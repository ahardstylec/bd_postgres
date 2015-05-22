namespace :db_benchmark do

  def trunc_tables
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE questions")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE answers")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE authors")
  end

  task run: :environment do
    trunc_tables
    base_1 = Question.bulk_insert(0.0001)
    Question.select_from_author
    Question.select_count
    trunc_tables
    base_5 = Question.bulk_insert(0.0005)
    Question.select_from_author
    Question.select_count
    trunc_tables
    base_10 = Question.bulk_insert(0.001)
    Question.select_from_author
    Question.select_count
    trunc_tables

    #
    # bench = Question.sql_pure_inserts(1)
    # puts sprintf("  %2.2fx faster than base", base_1.real / bench.real)
    # Question.select_from_author
    # Question.select_count
    # bench = Question.sql_pure_inserts(5)
    # puts sprintf("  %2.2fx faster than base", base_5.real / bench.real)
    # Question.select_from_author
    # Question.select_count
    # bench = Question.sql_pure_inserts(10)
    # puts sprintf("  %2.2fx faster than base", base_10.real / bench.real)
    # Question.select_from_author
    # Question.select_count

    trunc_tables
  end

end
