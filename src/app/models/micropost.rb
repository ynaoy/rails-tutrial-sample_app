class Micropost < ApplicationRecord
  belongs_to :user
  has_many :replays, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  REGEX = /@\w+[\w+|\s]/

  def replay_users
    self.content.scan(REGEX).join(",").strip.split(",").uniq
  end

  def is_replay?
    !(replay_users.empty?)
  end

  # Micropostのattributeをstrで検索する
  def Micropost.search_micropost(attribute = nil,str = nil)
    if attribute && str
      Micropost.where("#{attribute} LIKE ?","%#{str}%")
    end
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
