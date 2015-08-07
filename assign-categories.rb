require 'intercom'
require 'json'
require 'pp'
require 'yaml'

def parse_json(file)
  json = File.read(file)
  return JSON.parse(json)
end

CONFIG = 'config.yml'
@config = YAML::load(File.open(CONFIG))

GENRES = 'data/genres.json'
@genres = parse_json(GENRES)

CATEGORY_QUEUE = 'data/categories/queue.json'
@categories_queue = parse_json(CATEGORY_QUEUE)
@categories_queue.uniq!

DELIVERY_ROUND = "1C"

$intercom
@categories_hash = []
@users
@users_of_genre = []
@users_with_categories = []

def get_intercom_users
  $intercom = Intercom::Client.new(app_id: @config['intercom']['app_id'], api_key: @config['intercom']['api_key'])
  @users = $intercom.users.all
end

# Set "Collecting/Decorating" attribute value to "Collecting/ Decorating" value and then nils it. This is due to a key mismatch in the Famous emerging form.
def patch_collecting_decorating_bug
  @users_affected = @users.select {|user| user.custom_attributes["Collecting/Decorating"] != nil}
  if @users_affected.count > 0
    puts "#{@users_affected.count} users affected for Collecting/Decorating fix"
    @users_unaffected = @users.select {|user| user.custom_attributes["Collecting/ Decorating"] != nil}
    puts "#{@users_unaffected.count} users unaffected for Collecting/Decorating fix"
    @users_affected.each do |user|
      user.custom_attributes["Collecting/ Decorating"] = user.custom_attributes["Collecting/Decorating"]
      user.custom_attributes["Collecting/Decorating"] = nil
      $intercom.users.save(user)
    end
    get_intercom_users
    puts "#{@users_affected.count} users left to fix"
    puts "#{@users_unaffected.count} users consolidated post fix"
  else
    puts "No users affected for Collecting/Decorating fix"
  end
end

def get_user_counts
  # Selects users with taste data available
  @users_with_taste_data = @users.select {|user| (user.custom_attributes.has_key? "Budget") && (user.custom_attributes.has_key? "Genre")}
  puts "#{@users_with_taste_data.count} users with taste data"

  # Selects users with a taste category assignment
  @users_with_taste_category = @users.select {|user| user.custom_attributes["taste-category"] != nil}
  puts "#{@users_with_taste_category.count} users with a taste category"

  # Selects users that need a taste category assignment
  @users_need_taste_category = @users_with_taste_data.select {|user| user.custom_attributes["taste-category"] == nil}
  puts "#{@users_need_taste_category.count} users need a taste category"

  # Change this variable if you want to update existing taste category assignments
  @users = @users_need_taste_category
  puts "#{@users.count} users being addressed now"
end

# Get hash of users within a specific genre
def get_users_of_genre(genre_title)
  @users_of_genre = []
  @users_of_genre = @users.select {|user| user.custom_attributes["Genre"] == genre_title}
  puts "#{@users_of_genre.count} users in #{genre_title} genre"
end

# Get hash of taste categories
def get_categories_hash (genre, genre_title)
  file = "data/categories/#{genre}.json"
  json = File.read(file)
  return JSON.parse(json)
end

# Validate taste category attribute keys that to match data API
def validate_categories_attr(users, attr)
  @broken_attr = []
  attr.each do |attr|
    @users_with_attr = users.select {|user| user.custom_attributes.has_key? attr}
    if (@users_with_attr.count < 1)
      @broken_attr << attr
      puts "Broken #{attr} filter!"
    end
  end
  if @broken_attr.count > 0
    puts "#{@broken_attr.count} broken filters!"
    return false
  else
    puts "All filters passed!"
    return true
  end
end

def get_user_categories
  # Gets collection of category hashes that are included within the category queue
  @categories_selection = @categories_hash.select{|category| @categories_queue.include? category}

  # Gets users whose attribute hashes match taste category hashes
  @categories_selection.each do |key, hash|
    @users_of_category = @users_of_genre.select {|user| user.custom_attributes.values_at(*hash.keys) == hash.values}
    puts "#{key} - #{@users_of_category.count} users"

    # If users exist for category show the name and number of users
    @users_of_category.count > 0 ? assign_users_category(key, @users_of_category) : nil
  end
end

# Assigns users in the collection their taste category and saves them
def assign_users_category(category, users_of_category)
  users_of_category.each do |user|
    user.custom_attributes['taste-category'] = category
    user.custom_attributes['delivery-round'] = DELIVERY_ROUND
    @users_with_categories << user
    # Save user tast category data
    #$intercom.users.save(user)
  end
end

# Init
def init
  get_intercom_users
  #patch_collecting_decorating_bug
  get_user_counts
  @genres.each do |genre, genre_title|
    @categories_hash = get_categories_hash(genre, genre_title)
    @categories_attr = @categories_hash.first[1].keys
    get_users_of_genre(genre_title)
    validate_categories_attr(@users_of_genre, @categories_attr) ? get_user_categories : nil
  end

  puts "#{@users_with_categories.count} users assigned taste categories"
end

init
