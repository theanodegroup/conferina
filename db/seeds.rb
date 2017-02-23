# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_user = CreateAdminService.call
puts 'CREATED ADMIN USER: ' << admin_user.email


faddress = Faker::Address

# CategoryType
categories = ['Sports', 'Tech', 'Other']
category_hashes = categories.map do |category|
  {
    category: category,
    by_admin: Faker::Boolean.boolean(0.5),
  }
end
category_types = CategoryType.create(category_hashes)
puts 'CREATED CATEGORY TYPES'

# Event
# => CategoryType
100.times.map do
  start_date = Faker::Date.forward(180) + 7.days
  submission_date = Faker::Date.between(Faker::Date.backwards(7) - 3.days, start_date)
  notification = Faker::Date.between(Faker::Date.backwards(7), submission_date)
  {
    name: "#{Faker::Company.bs.titleize}",
    description: "#{Faker::Company.bs.titleize}",
    category: category_types.sample,
    timezone: Faker::Address.time_zone,
    start_date: start_date,
    end_date: Faker::Date.between(start_date, Faker::Date.forward(7)),
    coming_soon: Faker::Boolean.boolean(0.25),
    address: "#{faddress.street_name}, #{faddress.city}, #{faddress.state_abbr}, #{faddress.country}",
    call_for: Faker::Date.between(Faker::Date.backwards(7), notification),
    extra_desc: text,
    submission: submission_date,
    notification: notification,
    is_published: Faker::Boolean.boolean(0.75),
    lat: fake_lat,
    lng: fake_long,
  }
end
puts 'CREATED EVENTS'

# LocationType
location_types = ['indoor', 'outdoor']
location_type_hashes = location_types.map do |location_type|
  {
    category: location_type,
    by_admin: Faker::Boolean.boolean(0.5),
  }
end
location_types = LocationType.create(location_type_hashes)
puts 'CREATED LOCATION TYPES'

# Social
# => Event(one)
social_hashes = Event.find_each.map do |event|
  {
    website: Faker::Internet.url('example.com'),
    event: event,
    # No good way to generate social urls that aren't flawed
    # facebook: string,
    # twitter: string,
    # youtube: string,
  }
end
socials = Social.create(social_hashes)
puts 'CREATED SOCIALS'

# Tag
tags = ['indoor', 'outdoor']
tag_hashes = tags.map {|tag| { name: tag } }
tags = Tag.create(tag_hashes)

# User
user_hashes = person_types.map do |person_type|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user_name = Faker::Internet.user_name("#{last_name} #{first_name}", %w(. _ -))
  {
    email: Faker::Internet.safe_email(user_name),
    by_admin: Faker::Boolean.boolean(0.5),
  }
end
users = User.create(user_hashes)
puts 'CREATED USERS'

# PersonType
person_types = ['Good', 'Bad']
person_type_hashes = person_types.map do |person_type|
  {
    category: person_type,
    description: Faker::Hipster.sentence,
    by_admin: Faker::Boolean.boolean(0.5),
  }
end
person_types = PersonType.create(person_type_hashes)
puts 'CREATED PERSONTYPES'

# Person
# => PersonType, User

person_hashes = User.find_each.map do |user|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user_name = Faker::Internet.user_name("#{last_name} #{first_name}", %w(. _ -))
  {
    name: "#{first_name} #{last_name}",
    subtitle: Faker::Name.title,
    description: Faker::Company.bs,
    website: Faker::Internet.url('example.com'),
    phone: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.safe_email(user_name),
    event: events.sample,
    person_type: person_types.sample,
    user: user,
    # No good way to generate social urls that aren't flawed
    # facebook: string,
    # twitter: string,
    # youtube: string,
  }
end
persons = Person.create(person_hashes)
puts 'CREATED PERSONS'

# Venue
# => User, LocationType
venue_hashes = User.find_each.map do |user|
  street_name = faddress.street_name
  city = faddress.city
  state = faddress.state_abbr
  country = faddress.country
  {
    name: "#{Faker::Company.name} #{Center}",
    address: street_name,
    city: city,
    state: state,
    country: country,
    zip: faddress.zip_code,
    map_address: "#{street_name}, #{city}, #{state}, #{country}",
    phone: Faker::PhoneNumber.phone_number,
    description: fake_description_company,
    subtitle: Faker::Company.bs,
    lat: fake_lat,
    lng: fake_long,
    user_id: user,
    location_type: location_types.sample,
  }
end
venues = Venue.create(venue_hashes)
puts 'CREATED VENUES'

# Location
# => Event, LocationType, Venue
location_hashes = Event.find_each.map do |event|
  street_name = faddress.street_name
  city = faddress.city
  state = faddress.state_abbr
  country = faddress.country
  {
    name: "#{Faker::Company.name} #{Center}",
    address: street_name,
    city: city,
    state: state,
    country: country,
    zip: faddress.zip_code,
    map_address: "#{street_name}, #{city}, #{state}, #{country}",
    phone: Faker::PhoneNumber.phone_number,
    description: fake_description_company,
    subtitle: Faker::Company.bs,
    lat: fake_lat,
    lng: fake_long,
    user_id: user,
    event: event,
    location_type: location_types.sample,
    venue: venues.sample
  }
end
locations = Location.create(location_hashes)
puts 'CREATED LOCATIONS'

# SessionType
session_types = ['Good Session', 'Bad Session']
session_type_hashes = session_types.map do |session_type|
  {
    category: session_type,
    description: Faker::Hipster.sentence,
    by_admin: Faker::Boolean.boolean(0.5),
  }
end
session_types = SessionType.create(session_type_hashes)
puts 'CREATED SESSIONTYPES'

# Session
# => Event, Location

session_hashes = []
Event.find_each.map do |event|
  event_locations = event.locations.to_a

  session_hashes += (Faker::Number.between(2, 5)).times.map do
    start_date = Faker::Date.forward(180) + 7.days
    submission_date = Faker::Date.between(Faker::Date.backwards(7) - 3.days, start_date)
    notification = Faker::Date.between(Faker::Date.backwards(7), submission_date)
    start_time = Faker::Time.between(start_date, start_date, :morning)
    end_time = Faker::Time.between(start_date, start_date, :afternoon)
    {
      name: "#{Faker::Company.bs.titleize}",
      description: "#{Faker::Company.bs.titleize}",
      category: category_types.sample,
      timezone: Faker::Address.time_zone,
      start_date: start_date,
      coming_soon: Faker::Boolean.boolean(0.25),
      address: "#{faddress.street_name}, #{faddress.city}, #{faddress.state_abbr}, #{faddress.country}",
      extra_desc: text,
      submission: submission_date,
      notification: notification,
      is_published: Faker::Boolean.boolean(0.75),
      lat: fake_lat,
      lng: fake_long,

      start_time: start_time,
      end_time: end_time,
      other_time: "",
      event: event,
      session_type: session_type.sample,
      location: event_locations.sample,
    }
  end
end
sessions = Session.create(session_hashes)
puts 'CREATED SESSIONS'

# Feedback
# => User
feedback_hashes = (Faker::Number.between(5, 25)).map do
  {
    user: users.sample,
    content: Faker::Hipster.paragraphs(Faker::Number.between(1, 5))
  }
end
feedbacks = Feedback.create(feedback_hashes)
puts 'CREATED FEEDBACK'

# Favorite
# => User, Session, Location, Person
favorite_hashes = []
user.find_each do |user|
  [sessions, locations, persons].each do |favoritables|
    favorite_hashes += favoritables.sample(Faker::Number.between(0, 5)).each do |favoritable|
      {
        content: Faker::Hipster.sentences(Faker::Number.between(1,3)),
        favoritable: favoritable,
        favoritable_type: favoritable.class.name,
        user: user
      }
    end
  end
end
favorites = Favorite.create(note_hashes)
puts 'CREATED FAVORITES'

# Note
# => User, Session, Location, Person
note_hashes = []
user.find_each do |user|
  [sessions, locations, persons].each do |notables|
    note_hashes += notables.sample(Faker::Number.between(0, 5)).each do |notable|
      {
        content: Faker::Hipster.sentences(Faker::Number.between(1,3)),
        notable: notable,
        notable_type: notable.class.name,
        user: user
      }
    end
  end
end
notes = Note.create(note_hashes)
puts 'CREATED NOTES'

def fake_description_hipster
  Faker::Hipster.sentence
end

def fake_description_company
  Faker::Company.bs.title
end

def fake_lat
  (Faker::Boolean.boolean(0.5) ? Faker::Number.positive : Faker::Number.negative) % 90
end
def fake_long
  (Faker::Boolean.boolean(0.5) ? Faker::Number.positive : Faker::Number.negative) % 180
end