require 'intercom'
require 'json'
require 'pp'

@category_groups = []

@genres = {
  :abstract => "Abstract Art",
  :known => "Famous/ Emerging Artists",
  :classic => "Classic/ Fine Art",
  :photo => "Photography",
  :pop => "Pop Art",
  :street => "Street/ Urban Art"
}

@genres.each do |genre, genre_title|

  file_name = "../databases/categories/#{genre.key}.json"
  json = File.read(file_name)
  hash = JSON.parse(json)
  @category_groups << hash

end

json_abstract = File.read('../databases/categories/abstract.json')
hash_abstract = JSON.parse(json_abstract)
@categories_groups << hash_abstract

json_classic = File.read('../databases/categories/classic.json')
hash_classic = JSON.parse(json_classic)
@categories_groups << hash_classic

json_known = File.read('../databases/categories/known.json')
hash_known = JSON.parse(json_known)
@categories_groups << hash_known

json_photo = File.read('../databases/categories/photo.json')
hash_photo = JSON.parse(json_photo)
@categories_groups << hash_photo

json_pop = File.read('../databases/categories/pop.json')
hash_pop = JSON.parse(json_pop)
@categories_groups << hash_pop

json_street = File.read('../databases/categories/street.json')
hash_street = JSON.parse(json_street)
@categories_groups << hash_street

$delivery_round = 1

$intercom = Intercom::Client.new(app_id: 'dqv4tqvn', api_key: '8513ddd36eeac9caebb01a1b6daac7637af5c40f')

@users = $intercom.users.all
@users_categories = []

pp @categories_groups

=begin
  # Selects users with taste data available
  @users_with_taste_data = @users.select {|user| 
    (user.custom_attributes.has_key? "Budget") &&
    (user.custom_attributes.has_key? "Genre")
  }

  # Selects users that need a taste category assignment
  @users_need_taste_category = @users_with_taste_data.select {|user| 
    !(
    user.custom_attributes.has_key? "taste-category" && 
    user.custom_attributes["taste-category"] != nil
    )}

  puts "#{@users_with_taste_data.count} users with taste data"

  puts "#{@users_need_taste_category.count} users need a taste category"

  # Change this variable if you want to update existing taste category assignments
  @users_group = @users_need_taste_category

  puts "#{@users_group.count} users being addressed now"

  category_groups.each do |group|

    #Selects all users within a specific genre
    @users_genre = @users_group.select {|user| user.custom_attributes["Genre"] == group[:genre]}

    puts "#{@users_genre.count} users in #{group[:genre]} genre"

    #Checks for broken category attribute values that don't match data API
    def check_attributes(group_attr)
      @broken_filters = []

      group_attr.each do |filter|
        @users_with_attribute = @users.select {|user| user.custom_attributes.has_key? filter}
        if (@users_with_attribute.count < 1)
          @broken_filters << filter
          puts "Broken #{filter} filter!"
        end
      end

      if @broken_filters.count > 0
        puts "#{@broken_filters.count} broken filters!"
        return false
      else
        puts "All filters passed!"
        return true
      end

    end

    # Checks if category attributes are all valid
    if (@users_genre.count > 0 && check_attributes(group[:attr]))

      # Assigns category filters to variables that are easy to note
      filter_1 = group[:attr][0]
      filter_2 = group[:attr][1]
      filter_3 = group[:attr][2]

      # Searches only against taste categories included in category queue
      @loaded_categories = group[:categories].select{|category| @category_queue.include? category}

      # Search for list of users that match each category attribute set
      @loaded_categories.each do |key, value|
        @users_category = @users_genre.select {|user| 
          user.custom_attributes[filter_1] == value[0] && 
          user.custom_attributes[filter_2] == value[1] && 
          user.custom_attributes[filter_3] == value[2]
        }

        # If users exist for category show the name and number of users
        if @users_category.count > 0

          puts "#{key} - #{@users_category.count} users"

          # Assigns users in the collection their taste category and saves them
          @users_category.each do |user|
            user.custom_attributes['taste-category'] = key
            user.custom_attributes['delivery-round'] = $delivery_round
            @users_categories << user
            # Save user tast category data
            # $intercom.users.save(user)
          end
        end

      end

    end

  end

  puts "#{@users_categories.count} users assigned taste categories"
=end
