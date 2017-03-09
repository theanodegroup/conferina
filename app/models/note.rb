class Note < ActiveRecord::Base
  belongs_to :notable, polymorphic: true
  belongs_to :user

  def readable_notable_type
    self.notable_type.gsub('Type', '')
  end
end
