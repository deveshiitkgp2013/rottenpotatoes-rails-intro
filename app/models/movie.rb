class Movie < ActiveRecord::Base
    
    scope :all_ratings, ->{ distinct.order("ratings").pluck("ratings") }
    scope :with_ratings, ->(selected_ratings) { where(rating:selected_ratings) }
    scope :order_and_ratings, ->(selected_ratings,order) { where(rating:selected_ratings).order(order)}
end


