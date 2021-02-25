class Movie < ActiveRecord::Base
    def all_ratings
        @ratings = ['G','PG','PG-13','R']
        
        return @ratings
    end
end

h = Movie.new();
puts h.all_ratings