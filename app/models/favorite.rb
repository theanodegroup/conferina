class Favorite < ActiveRecord::Base
  belongs_to :favoritable, polymorphic: true
end
