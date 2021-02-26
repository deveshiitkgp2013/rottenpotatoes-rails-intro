class Movie < ActiveRecord::Base
    
    scope :all_ratings, ->{['G','PG','PG-13','R'] }
    scope :with_ratings, ->(selected_ratings) { where(rating:selected_ratings) }
    scope :order_and_ratings, ->(selected_ratings,order) { where(rating:selected_ratings).order(order)}
end


