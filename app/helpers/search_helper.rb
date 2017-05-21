module SearchHelper
  def multi_search_query(base_query, query_params, search_fields_hash)
		# Dynamically build the where query using a base query, query params and search field hash
		search_fields_hash.each do |search_field, comparator|
		  search_query = query_params[search_field]
	    query = comparator == 'ILIKE' ? "%#{search_query}%" : search_query
  		base_query = base_query.where("#{search_field} #{comparator} ?", query) if search_query.present?
		end
		base_query
  end
end
