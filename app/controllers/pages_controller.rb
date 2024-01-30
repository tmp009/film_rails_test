class PagesController < ApplicationController
    def home
        @random_movie = Movie.order("RANDOM()").first
    end
end
