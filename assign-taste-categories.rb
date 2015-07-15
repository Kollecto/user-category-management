require 'intercom'

category_groups = [
  {
  :genre => "Pop Art",
  :attr => ["Budget","Collecting/ Decorating","Known/ Unknown/ Emerging","Playful/serious"],
  :categories => {
    "PopB" => ["$100-$300","Collecting","known artists","serious"],
    "PopC" => ["$100-$300","Decorating","known artists","serious"],
    "PopD" => ["$100-$300","Collecting","unknown artists","serious"],
    "PopE" => ["$100-$300","Decorating","unknown artists","serious"],
    "PopF" => ["$100-$300","Collecting","known artists","playful"],
    "PopG" => ["$100-$300","Decorating","known artists","playful"],
    "PopH" => ["$100-$300","Collecting","unknown artists","playful"],
    "PopI" => ["$100-$300","Decorating","unknown artists","playful"],
    "PopJ" => ["$300-$500","Collecting","known artists","serious"],
    "PopK" => ["$300-$500","Decorating","known artists","serious"],
    "PopL" => ["$300-$500","Collecting","unknown artists","serious"],
    "PopM" => ["$300-$500","Decorating","unknown artists","serious"],
    "PopN" => ["$300-$500","Collecting","known artists","playful"],
    "PopO" => ["$300-$500","Decorating","known artists","playful"],
    "PopP" => ["$300-$500","Collecting","unknown artists","playful"],
    "PopQ" => ["$300-$500","Decorating","unknown artists","playful"],
    "PopR" => ["$500-$1000","Collecting","known artists","serious"],
    "PopS" => ["$500-$1000","Decorating","known artists","serious"],
    "PopT" => ["$500-$1000","Collecting","unknown artists","serious"],
    "PopU" => ["$500-$1000","Decorating","unknown artists","serious"],
    "PopV" => ["$500-$1000","Collecting","known artists","playful"],
    "PopW" => ["$500-$1000","Decorating","known artists","playful"],
    "PopX" => ["$500-$1000","Collecting","unknown artists","playful"],
    "PopY" => ["$500-$1000","Decorating","unknown artists","playful"],
    "PopZ" => ["$1000-$2000","Collecting","known artists","serious"],
    "PopAA" => ["$1000-$2000","Decorating","known artists","serious"],
    "PopAB" => ["$1000-$2000","Collecting","unknown artists","serious"],
    "PopAC" => ["$1000-$2000","Decorating","unknown artists","serious"],
    "PopAD" => ["$1000-$2000","Collecting","known artists","playful"],
    "PopAE" => ["$1000-$2000","Decorating","known artists","playful"],
    "PopAF" => ["$1000-$2000","Collecting","unknown artists","playful"],
    "PopAG" => ["$1000-$2000","Decorating","unknown artists","playful"],
    "PopAH" => ["$2000-$3000","Collecting","known artists","serious"],
    "PopAI" => ["$2000-$3000","Decorating","known artists","serious"],
    "PopAJ" => ["$2000-$3000","Collecting","unknown artists","serious"],
    "PopAK" => ["$2000-$3000","Decorating","unknown artists","serious"],
    "PopAL" => ["$2000-$3000","Collecting","known artists","playful"],
    "PopAM" => ["$2000-$3000","Decorating","known artists","playful"],
    "PopAN" => ["$2000-$3000","Collecting","unknown artists","playful"],
    "PopAO" => ["$2000-$3000","Decorating","unknown artists","playful"],
    "PopAP" => ["$3,000+","Collecting","known artists","serious"],
    "PopAQ" => ["$3,000+","Decorating","known artists","serious"],
    "PopAR" => ["$3,000+","Collecting","unknown artists","serious"],
    "PopAS" => ["$3,000+","Decorating","unknown artists","serious"],
    "PopAT" => ["$3,000+","Collecting","known artists","playful"],
    "PopAU" => ["$3,000+","Decorating","known artists","playful"],
    "PopAV" => ["$3,000+","Collecting","unknown artists","playful"],
    "PopAW" => ["$3,000+","Decorating","unknown artists","playful"],
    }
  },
  {
  :genre => "Street/ Urban Art",
  :attr => ["Budget","Collecting/ Decorating","Known/ Unknown/ Emerging","Street/Urban/Graffiti"],
  :categories => {
    "StreetB" => ["$100-$300","Collecting","known artists","Street Art"],
    "StreetC" => ["$100-$300","Decorating","known artists","Street Art"],
    "StreetD" => ["$100-$300","Collecting","unknown artists","Street Art"],
    "StreetE" => ["$100-$300","Decorating","unknown artists","Street Art"],
    "StreetF" => ["$100-$300","Collecting","known artists","Classic Graffiti Art"],
    "StreetG" => ["$100-$300","Decorating","known artists","Classic Graffiti Art"],
    "StreetH" => ["$100-$300","Collecting","unknown artists","Classic Graffiti Art"],
    "StreetI" => ["$100-$300","Decorating","unknown artists","Classic Graffiti Art"],
    "StreetJ" => ["$100-$300","Collecting","known artists","Urban Art"],
    "StreetK" => ["$100-$300","Decorating","known artists","Urban Art"],
    "StreetL" => ["$100-$300","Collecting","unknown artists","Urban Art"],
    "StreetM" => ["$100-$300","Decorating","unknown artists","Urban Art"],
    "StreetN" => ["$300-$500","Collecting","known artists","Street Art"],
    "StreetO" => ["$300-$500","Decorating","known artists","Street Art"],
    "StreetP" => ["$300-$500","Collecting","unknown artists","Street Art"],
    "StreetQ" => ["$300-$500","Decorating","unknown artists","Street Art"],
    "StreetR" => ["$300-$500","Collecting","known artists","Classic Graffiti Art"],
    "StreetS" => ["$300-$500","Decorating","known artists","Classic Graffiti Art"],
    "StreetT" => ["$300-$500","Collecting","unknown artists","Classic Graffiti Art"],
    "StreetU" => ["$300-$500","Decorating","unknown artists","Classic Graffiti Art"],
    "StreetV" => ["$300-$500","Collecting","known artists","Urban Art"],
    "StreetW" => ["$300-$500","Decorating","known artists","Urban Art"],
    "StreetX" => ["$300-$500","Collecting","unknown artists","Urban Art"],
    "StreetY" => ["$300-$500","Decorating","unknown artists","Urban Art"],
    "StreetZ" => ["$500-1,000","Collecting","known artists","Street Art"],
    "StreetAA" => ["$500-1,000","Decorating","known artists","Street Art"],
    "StreetAB" => ["$500-1,000","Collecting","unknown artists","Street Art"],
    "StreetAC" => ["$500-1,000","Decorating","unknown artists","Street Art"],
    "StreetAD" => ["$500-1,000","Collecting","known artists","Classic Graffiti Art"],
    "StreetAE" => ["$500-1,000","Decorating","known artists","Classic Graffiti Art"],
    "StreetAF" => ["$500-1,000","Collecting","unknown artists","Classic Graffiti Art"],
    "StreetAG" => ["$500-1,000","Decorating","unknown artists","Classic Graffiti Art"],
    "StreetAH" => ["$500-1,000","Collecting","known artists","Urban Art"],
    "StreetAI" => ["$500-1,000","Decorating","known artists","Urban Art"],
    "StreetAJ" => ["$500-1,000","Collecting","unknown artists","Urban Art"],
    "StreetAK" => ["$500-1,000","Decorating","unknown artists","Urban Art"],
    "StreetAL" => ["$1,000-$2,000","Collecting","known artists","Street Art"],
    "StreetAM" => ["$1,000-$2,000","Decorating","known artists","Street Art"],
    "StreetAN" => ["$1,000-$2,000","Collecting","unknown artists","Street Art"],
    "StreetAO" => ["$1,000-$2,000","Decorating","unknown artists","Street Art"],
    "StreetAP" => ["$1,000-$2,000","Collecting","known artists","Classic Graffiti Art"],
    "StreetAQ" => ["$1,000-$2,000","Decorating","known artists","Classic Graffiti Art"],
    "StreetAR" => ["$1,000-$2,000","Collecting","unknown artists","Classic Graffiti Art"],
    "StreetAS" => ["$1,000-$2,000","Decorating","unknown artists","Classic Graffiti Art"],
    "StreetAT" => ["$1,000-$2,000","Collecting","known artists","Urban Art"],
    "StreetAU" => ["$1,000-$2,000","Decorating","known artists","Urban Art"],
    "StreetAV" => ["$1,000-$2,000","Collecting","unknown artists","Urban Art"],
    "StreetAW" => ["$1,000-$2,000","Decorating","unknown artists","Urban Art"],
    "StreetAX" => ["$2,000-$3,000","Collecting","known artists","Street Art"],
    "StreetAY" => ["$2,000-$3,000","Decorating","known artists","Street Art"],
    "StreetAZ" => ["$2,000-$3,000","Collecting","unknown artists","Street Art"],
    "StreetBA" => ["$2,000-$3,000","Decorating","unknown artists","Street Art"],
    "StreetBB" => ["$2,000-$3,000","Collecting","known artists","Classic Graffiti Art"],
    "StreetBC" => ["$2,000-$3,000","Decorating","known artists","Classic Graffiti Art"],
    "StreetBD" => ["$2,000-$3,000","Collecting","unknown artists","Classic Graffiti Art"],
    "StreetBE" => ["$2,000-$3,000","Decorating","unknown artists","Classic Graffiti Art"],
    "StreetBF" => ["$2,000-$3,000","Collecting","known artists","Urban Art"],
    "StreetBG" => ["$2,000-$3,000","Decorating","known artists","Urban Art"],
    "StreetBH" => ["$2,000-$3,000","Collecting","unknown artists","Urban Art"],
    "StreetBI" => ["$2,000-$3,000","Decorating","unknown artists","Urban Art"],
    "StreetBJ" => ["$3,000+","Collecting","known artists","Street Art"],
    "StreetBK" => ["$3,000+","Decorating","known artists","Street Art"],
    "StreetBL" => ["$3,000+","Collecting","unknown artists","Street Art"],
    "StreetBM" => ["$3,000+","Decorating","unknown artists","Street Art"],
    "StreetBN" => ["$3,000+","Collecting","known artists","Classic Graffiti Art"],
    "StreetBO" => ["$3,000+","Decorating","known artists","Classic Graffiti Art"],
    "StreetBP" => ["$3,000+","Collecting","unknown artists","Classic Graffiti Art"],
    "StreetBQ" => ["$3,000+","Decorating","unknown artists","Classic Graffiti Art"],
    "StreetBR" => ["$3,000+","Collecting","known artists","Urban Art"],
    "StreetBS" => ["$3,000+","Decorating","known artists","Urban Art"],
    "StreetBT" => ["$3,000+","Collecting","unknown artists","Urban Art"],
    "StreetBU" => ["$3,000+","Decorating","unknown artists","Urban Art"],
    }
  }
]

@category_queue = ["StreetC","StreetE","StreetL","StreetM","StreetO","StreetP","StreetQ","StreetW","StreetY","StreetAA","StreetAC","StreetAF","StreetAK","StreetAL","StreetAO","StreetAT","StreetAW","StreetBB","StreetBJ","StreetBR","PopE","PopG","PopI","PopJ","PopM","PopT"]

$delivery_round = 1

$intercom = Intercom::Client.new(app_id: 'dqv4tqvn', api_key: '8513ddd36eeac9caebb01a1b6daac7637af5c40f')

@users = $intercom.users.all
@users_categories = []

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
          $intercom.users.save(user)
        end
      end

    end

  end

end

puts "#{@users_categories.count} users assigned taste categories"
