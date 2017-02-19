class User < ApplicationRecord
    attr_accessor :password, :password_confirmation
    before_save { self.email = email.downcase }
    before_create :encrypt_password, :set_token
    validates :name,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                     uniqueness: {case_sensitive: false }
    has_secure_password
    has_many :devices


    # Returns the hash digest of the given string.
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def self.new_token
        SecureRandom.urlsafe_base64
    end


    private 

    def encrypt_password
        self.password_digest = User.digest(password)
    end

    def set_token
        self.token = User.new_token
    end

end
