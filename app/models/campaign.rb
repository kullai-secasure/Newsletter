class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :template, optional: true
  has_many :campaign_subscribers
  has_many :subscribers, through: :campaign_subscribers

  validates :name, presence: true
  validates :subject, presence: true
  validates :content, presence: true

  enum status: { draft: 0, scheduled: 1, sending: 2, sent: 3 }

  scope :recent, -> { order(created_at: :desc).limit(10) }

  def preview_token
    Digest::SHA256.hexdigest("#{id}-#{created_at}")
  end
end
