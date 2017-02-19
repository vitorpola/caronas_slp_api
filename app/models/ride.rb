class Ride < ApplicationRecord
    belongs_to :driver, class_name: 'User'
    has_many :passengers
    belongs_to :from_city, class_name: 'City'
    belongs_to :from_neighborhood, class_name: 'Neighborhood'
    belongs_to :to_city, class_name: 'City'
    belongs_to :to_neighborhood, class_name: 'Neighborhood'
end
