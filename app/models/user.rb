class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  validates :name, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_one_attached :image

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)

    if user.nil?
      user = find_by(email: auth.info.email)
      if user
        user.update(provider: auth.provider, uid: auth.uid)
      else
        user = create(
          email: auth.info.email,
          name: auth.info.name,
          provider: auth.provider,
          uid: auth.uid,
          password: Devise.friendly_token[0, 20]
        )
      end
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def own?(object)
    id == object&.user_id
  end

  def like(post)
    like_posts << post
  end

  def unlike(post)
    like_posts.destroy(post)
  end

  def like?(post)
    like_posts.include?(post)
  end
end
