json.extract! movie, :id, :film_id, :title, :description, :created_at, :updated_at
json.url movie_url(movie, format: :json)
