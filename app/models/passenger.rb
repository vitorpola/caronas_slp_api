class Passenger < ApplicationRecord
    belongs_to :ride
    has_one :user
end
