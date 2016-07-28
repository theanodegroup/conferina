class RegistrationsController < Devise::RegistrationsController
	def after_sign_up_path_for(resource)
		current_user.session_types << SessionType.where(by_admin: true)
		current_user.location_types << LocationType.where(by_admin: true)
		current_user.person_types << PersonType.where(by_admin: true)
		current_user.category_types << CategoryType.where(by_admin: true)

		root_path
	end
end