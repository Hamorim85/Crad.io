class Influencer < ApplicationRecord
  belongs_to :follower, optional: true # Temporary solution
  has_many :influencer_mails, dependent: :destroy
  has_many :mailings, through: :influencer_mails
  has_many :influencer_categories, dependent: :destroy
  has_many :categories, through: :influencer_categories
  validates :username, uniqueness: true
  validates :username, :followers_count, :following_count, presence: true

  mount_uploader :photo, PhotoUploader

  def instagram_path
    "http://www.instagram.com/#{username}"
  end

  def follow_ratio
    followers_count / following_count.to_f
  end

  def name
    full_name.empty? ? username : full_name
  end

  def json
    follower.json
  end

  def email
    parse_email if super.nil? || super.empty?
    super
  end

  def parse_email
    ParseService.email(self)
  end

  def ig_followers
    number_humanizer(followers_count)
  end

  def ig_following
    number_humanizer(following_count)
  end

  def update_photo
    self.remote_photo_url = ig_pic_url
    save
  rescue Cloudinary::CarrierWave::UploadError => exs
    p exs.to_s
    follower.visit
    follower.promote!
    reload
    retry
  rescue CloudinaryException => exs
    p exs.to_s
    p 'Waiting 2 seconds to retry'
    sleep 2
    retry
  end

  def reparse!
    follower.promote!
  end

  def engagement_rate
    media_score / followers_count.to_f * 100
  end

  def self.search(params)
    # search_result = order(followers_count: :DESC)
    search_result = order(media_score: :DESC)
    search_result = search_result.joins(:categories).where(categories: {id: params[:categories]}).distinct if params[:categories].present?
    search_result = search_result.where('following_count < ?', params[:following_count].to_i) if params[:following_count].present?
    search_result = search_result.where('followers_count > ?', params[:followers_count].to_i) if params[:followers_count].present?
    search_result
  end

  private

  def number_humanizer(number)
    return "#{(number / 1_000_000.0).round(1)}m" if number > 999_999
    return "#{(number / 1_000.0).round(1)}k" if number > 999
    number
  end
end
