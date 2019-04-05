class FaceoffResult < ApplicationRecord
  validates :team1_id, presence: true
  validates :team2_id, presence: true
end
