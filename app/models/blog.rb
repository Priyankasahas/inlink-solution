class Blog < ActiveRecord::Base
  belongs_to :user

  scope :user, -> (user_id) { where user_id: user_id }
  scope :title, -> (title) { where("title like ?", "#{title}%")}
end
