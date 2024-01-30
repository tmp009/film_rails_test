class Actor < ApplicationRecord
    self.table_name = "actor"
    def search
      Actor.find_by(actor_id:params[:query])
    end
end
