class Micropost < ApplicationRecord
  
  belongs_to :user
  
  has_one_attached :image
  
  # default_scopeでマイクロポストを順序付ける
  default_scope -> { order(created_at: :desc) }
  
  # マイクロポストのuser_idに対するバリデーション
  validates :user_id, presence: true
  
  # Micropostモデルのバリデーション
  validates :content, presence: true, length: { maximum: 140 }
  
  # 画像バリデーション
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: "must be a valid image format" },
                    size: { less_than: 5.megabytes,
                            message: "should be less than 5MB" }
  
  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
  
end
