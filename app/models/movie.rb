class Movie < ActiveRecord::Base
    
    scope :with_ratings, ->(selected_ratings) { where(rating:selected_ratings) }
    scope :all_ratings, ->{ distinct.order("rating").pluck("rating") }
    scope :order_and_ratings, ->(selected_ratings,order) { where(rating:selected_ratings).order(order)}
end


