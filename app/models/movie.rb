class Movie < ActiveRecord::Base
    
    scope :with_ratings, ->(selected_ratings) { where(rating:selected_ratings) }
    scope :all_ratings, ->{['G','PG','PG-13','R']}
end


