class Movie < ActiveRecord::Base
    has_many :reviews  
    has_many :users, through: :reviews
    validates :title, :summary, :img, :trailer, presence: true
end
