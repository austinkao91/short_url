# == Schema Information
#
# Table name: shortened_urls
#
#  id        :integer          not null, primary key
#  long_url  :string
#  short_url :string
#  user_id   :integer
#

class ShortenedUrl < ActiveRecord::Base

  def self.random_code

    code = SecureRandom::urlsafe_base64
    while self.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64
    end
    code

  end

  def self.create!(user, long_url)
    short_url = self.random_code
    new_url = ShortenedUrl.new({long_url: long_url, user_id: user.id, short_url: short_url})
    new_url.save!
  end

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :short_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user
    )

  def num_clicks
    visitors.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.select(:user_id).where('visits.created_at > ?', 10.minutes.ago)
  end

end
