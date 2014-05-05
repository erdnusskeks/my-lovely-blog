# There isn't much to this file - but note that the Post class inherits from ActiveRecord::Base.
# Active Record supplies a great deal of functionality to your Rails models for free,
# including basic database CRUD (Create, Read, Update, Destroy) operations, data validation,
# as well as sophisticated search support and the ability to relate multiple models to one another.

class Post < ActiveRecord::Base
  has_many :comments
  validates :title,
    presence: true,
    length: { minimum: 5 }
end

# Adding:
  # validates :title, presence: true,
    # length: { minimum: 5 }
# will ensure that
# - all posts have a title
# - that is at least five characters long.

# Rails can validate a variety of conditions in a model, including
# - the presence or uniqueness of columns,
# - their format, and
# - the existence of associated objects.


