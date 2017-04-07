class Favorite < ActiveRecord::Base
  belongs_to :favoritable, polymorphic: true
  belongs_to :user

  STYLE_STAR = 'star'
  STYLE_LINK = 'link'
end
