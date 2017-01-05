class Message < ApplicationRecord
    belongs_to :sender, through: :user 
    belongs_to :receiver, through: :user 
end
