module ApplicationHelper
  def xeditable?(object = nil)
    current_user.try(:admin?)
  end
end
