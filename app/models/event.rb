class Event < ApplicationRecord
  belongs_to :user, foreign_key: true
end
