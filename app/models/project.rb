class Project < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  def prev
    Project.where(["id > ?", id ]).first
  end

  def next
    Project.where(["id < ?", id]).last
  end

end
