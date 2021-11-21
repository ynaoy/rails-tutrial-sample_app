class Replay < ApplicationRecord
  belongs_to :micropost
  default_scope -> { order(created_at: :desc) }
  validates :replay_to, presence: true
  validates :replay_from, presence: true
  validates :micropost_id, presence: true

end
