class RegistrationsController < Devise::RegistrationsController
	def after_sign_up_path_for(resource)
		session_types = SessionType.where(by_admin: true)
		location_types = LocationType.where(by_admin: true)
		person_types = PersonType.where(by_admin: true)
		category_types = CategoryType.where(by_admin: true)

		session_types.each do |item|
			session_type = SessionType.create(category: item.category, avatar: item.avatar)
			current_user.session_types << session_type
		end

		location_types.each do |item|
			location_type = LocationType.create(category: item.category, avatar: item.avatar)
			current_user.location_types << location_type
		end

		person_types.each do |item|
			person_type = PersonType.create(category: item.category, avatar: item.avatar)
			current_user.person_types << person_type
		end

		category_types.each do |item|
			category_type = CategoryType.create(category: item.category, avatar: item.avatar)
			current_user.category_types << category_type
		end

		root_path
	end

	def destroy
		session_types = current_user.session_types
		location_types = current_user.location_types
		person_types = current_user.person_types
		category_types = current_user.category_types
		events = current_user.events

		session_types.each do |item|
			SessionType.find_by_id(item.id).destroy
		end

		location_types.each do |item|
			LocationType.find_by_id(item.id).destroy
		end

		person_types.each do |item|
			PersonType.find_by_id(item.id).destroy
		end

		category_types.each do |item|
			CategoryType.find_by_id(item.id).destroy
		end

		events.each do |item|
	      Event.find_by_id(item.id).destroy
	    end

		super
	end
end