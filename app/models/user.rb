class User < ActiveRecord::Base
    has_secure_password
    has_many :reviews
    has_many :movies, through: :reviews
    validates :username, :email, :password, presence: true, uniqueness: true
end
