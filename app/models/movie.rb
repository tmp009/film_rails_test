class Movie < ApplicationRecord
    self.table_name = "film"
    def search
        Movie.find_by(film_id:params[:query])
    end
end
