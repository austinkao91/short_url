# == Schema Information
#
# Table name: visits
#
#  id           :integer          not null, primary key
#  short_url_id :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Visit < ActiveRecord::Base

  validates :short_url_id, presence: true
  validates :user_id, presence: true

  def self.record_visit(user,shortened_url)
    v = Visit.create({user_id: user.id, short_url_id: shortened_url.id})
    v.save!
  end

  belongs_to(
      :shortened_url,
      class_name: "ShortenedUrl",
      foreign_key: :shortened_url_id,
      primary_key: :id
  )
  belongs_to(
      :user,
      class_name: "User",
      foreign_key: :user_id,
      primary_key: :id
  )
end
