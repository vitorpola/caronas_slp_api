class City < ApplicationRecord
    def self.new_city(name)
        find_by(name: name) || create(name: name)
    end
end
