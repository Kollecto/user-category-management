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
@categories_hash = {}
@categories_attr = []

DELIVERY_ROUND = "2"

DELIVERY_ATTR = "Budget"
@delivery_attr_hash = {}

$intercom
@categories_hash = []
@users
@users_of_genre = {}
@users_with_category = {}
@users_assigned_categories = {}

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
      #$intercom.users.save(user)
    end
    get_intercom_users
    puts "#{@users_affected.count} users left to fix"
    puts "#{@users_unaffected.count} users consolidated post fix"
  else
    puts "No users affected for Collecting/Decorating fix"
  end
end

def get_user_sets
  # Selects users with taste data available
  @users_with_taste_data = @users.select {|user| (user.custom_attributes.has_key? "Budget") && (user.custom_attributes.has_key? "Genre")}
  puts "#{@users_with_taste_data.count} users with taste data"

  # Selects users with a taste category assignment
  @users_with_category = @users.select {|user| user.custom_attributes["taste-category"] != nil}
  puts "#{@users_with_category.count} users with a taste category"

  # Selects users that need a taste category assignment
  @users_need_taste_category = @users_with_taste_data.select {|user| user.custom_attributes["taste-category"] == nil}
  puts "#{@users_need_taste_category.count} users need a taste category"

  # Change this variable if you want to update existing taste category assignments
  @users = @users_with_category
  puts "@users set to @users_with_category - #{@users.count}"
end

# Get hash of users within a specific genre
def get_users_of_genre(genre_title)
  @users_of_genre = @users.select {|user| user.custom_attributes["Genre"] == genre_title}
  puts "#{@users_of_genre.count} users in #{genre_title} genre"
end

# Get hash of taste categories
def get_categories_hash (genre, genre_title)
  file = "data/categories/#{genre}.json"
  json = File.read(file)
  @categories_hash = JSON.parse(json)
  @categories_attr = @categories_hash.first[1].keys
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
    @users_of_category.count > 0 ? publish_user_categories(key, @users_of_category) : nil
  end
end

# Assigns users in the collection their taste category and saves them
def publish_user_categories(category, users_of_category)
  users_of_category.each do |user|
    user.custom_attributes['taste-category'] = category
    user.custom_attributes['delivery-category'] = category
    user.custom_attributes['delivery-round'] = DELIVERY_ROUND
    @users_assigned_categories << user
    # Save user tast category data
    #$intercom.users.save(user)
  end
end

def assign
  @genres.each do |genre, genre_title|
    get_categories_hash(genre, genre_title)
    get_users_of_genre(genre_title)
    validate_categories_attr(@users_of_genre, @categories_attr) ? get_user_categories : nil
  end
  puts "#{@users_assigned_categories.count} users assigned taste categories"
end

def pivot
  if DELIVERY_ATTR != "category"

    @genres.each do |genre, genre_title|
      get_users_of_genre(genre_title)
      get_categories_hash(genre, genre_title)
      @delivery_attr_hash = Hash.new
      @categories_hash.each do |category, attr_hash|
        attr_value = attr_hash[DELIVERY_ATTR]
        if @delivery_attr_hash[attr_value] == nil
          @delivery_attr_hash[attr_value] = [category]
        else
          @delivery_attr_hash[attr_value].push(category)
        end
      end
      @users_of_genre.each do |user|
        user_bucket_value = user.custom_attributes[DELIVERY_ATTR]
        taste_category = user.custom_attributes['taste-category']
				bucket = @delivery_attr_hash.find {|key, bucket| key.delete(',').delete('$') == user_bucket_value.delete(',').delete('$')}
        @bucket_categories =  @delivery_bucket_categories = (bucket)[1]
        bucket_categories_key = (bucket)[0]
        category_index = @bucket_categories.index(taste_category)
				bucket_index = @delivery_attr_hash.keys.index(bucket_categories_key)
				@delivery_attr_buckets = @delivery_attr_hash.values

				pp bucket_index

        begin
          if (category_index >= @delivery_bucket_categories.length - 1)
            category_index = 0
          else
            category_index += 1
          end
          delivery_category = @delivery_bucket_categories[category_index]
          pp delivery_category
          if delivery_category == taste_category
            bucket_index += 1
            if (bucket_index >= @delivery_attr_buckets.length - 1)
              bucket_index = category_index = 0
            end
            @delivery_bucket_categories = @delivery_attr_buckets[bucket_index]
            puts "! Bucket Pivot!"
            if (@delivery_bucket_categories == @bucket_categories)
              puts "! Bucket options have cycled out !"
              break
            end
            redo
          end
        end until @categories_queue.include? delivery_category

        if !(user.custom_attributes['delivery-categories'])
          user.custom_attributes['delivery-category'] = delivery_category
          delivery_categories = [taste_category,delivery_category].to_s
          user.custom_attributes['delivery-categories'] = delivery_categories
          puts "#{user.email} | #{taste_category} | #{delivery_category} | #{delivery_categories}"
          #$intercom.users.save(user)
        else
          delivery_categories = user.custom_attributes['delivery-categories'].split(",")
          if !(delivery_categories.include? delivery_category)
            user.custom_attributes['delivery-category'] = delivery_category
            delivery_categories.push(delivery_category)
            delivery_categories = "#{delivery_categories}"
            puts "#{user.email} | #{taste_category} | #{delivery_category} | #{delivery_categories}"
            #$intercom.users.save(user)
          else
            puts "!The #{user_bucket_value} bucket has cylcled out!"
          end
        end
      end
    end
  end
end

#Delete (nil) or reset taste category
def set_category(user_set, category)
  if (user_set == "all")
    @users.each do |user|
      publish_deleted_category(user, category)
    end
  elsif (user_set.scan(/@/).length == 1)
    user = @users.find {|user| user.email == user_set}
    publish_deleted_category(user, category)
  end
end

def publish_deleted_category(user, category)
  user.custom_attributes["taste-category"] = category
  user.custom_attributes["delivery-category"] = category
  #user.custom_attributes["delivery-categories"] = nil
  $intercom.users.save(user)
  puts "#{user.name} category set to #{category}"
end

def init
  get_intercom_users
  get_user_sets
end
