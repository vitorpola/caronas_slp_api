class Neighborhood < ApplicationRecord
    belongs_to :city
    def self.new_neighborhood(name, city_id)
        find_by(name: name, city_id: city_id) || create(name: name, city_id: city_id)
    end
end
