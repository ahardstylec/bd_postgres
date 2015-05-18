require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "postgres insert 1.000.000" do
    Question.bulk_insert(0.01)
  end
  #
  # test "postgres insert 1.000.000 optimized" do
  #   Question.bulk_insert_optimized(0.01)
  # end

  test "sql_pure_inserts 1.000.000 optimized" do
    Question.sql_pure_inserts(0.01)
  end
  #
  # test "postgres insert 1.000.000 optimized" do
  #   Question.bulk_insert(1)
  # end
  #
  # test "postgres insert 5.000.000" do
  #   Question.bulk_insert(5)
  # end
  #
  # test "postgres insert 5.000.000 optimized" do
  #   Question.sql_pure_inserts(5)
  # end
  #
  # test "postgres insert 10.000.000" do
  #   Question.bulk_insert(10)
  # end
  #
  # test "postgres insert 10.000.000 optimized" do
  #   Question.sql_pure_inserts(10)
  # end
end
