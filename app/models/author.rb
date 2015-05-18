class Author < ActiveRecord::Base
  has_many :questions
end
