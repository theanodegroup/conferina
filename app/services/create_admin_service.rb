class CreateAdminService
  # This service does not store data, so class methods are used.

  def self.call
     # Assumed already created if fails
    User.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |user|
      user.password = ENV['ADMIN_PASSWORD']
      user.role = :admin
    end
  end
end
