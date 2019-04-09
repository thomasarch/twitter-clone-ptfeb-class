#Things to do

- paste in seed file
```
require 'open-uri'
require 'yaml'

def destroy_all
    User.destroy_all
    Tweet.destroy_all
    # TweetTag.destroy_all
    # Tag.destroy_all
    FileUtils.rm_rf(Dir['app/assets/images/autopics/*'])
    p 'everything is gone'
end


def create_self
    User.create!(name: 'Default User', username: 'default', bio: "It's me!", location: 'Asheville', email: "user@default.com", password: '111111')
end


def fill_character_array(number)
    character_array = []

    until character_array.count == number
        character = Faker::TvShows::TwinPeaks.character
        character_array.push(character) unless character_array.include?(character)
    end    
    character_array
end


def create_characters(character_array)
    character_array.each do |character|

        p "Creating #{character}"

        pic = scrape_image(character)
        name = character
        username = character.delete(' ')
        
        User.create!(
            name: name, 
            username: username, 
            bio: Faker::TvShows::TwinPeaks.quote, 
            location: Faker::TvShows::TwinPeaks.location, 
            email: "#{username}@tp.com", 
            password: "111111", 
            autopic: "autopics/#{username}.png", 
            bot: :true
        )

    end
    p "finished!"
end

def scrape_image(character)
    search_string = character.gsub(/ /, '+')
    
    img = Nokogiri::HTML(open("https://www.google.com/search?tbm=isch&q=#{search_string}"))
        .css('img').attr('src')
        .value

    filename = character.delete(' ')
    File.open("app/assets/images/autopics/#{filename}.png",'wb'){ |f| f.write(open(img).read) }
end

destroy_all

create_self

character_array = fill_character_array(10)

create_characters(character_array)
```



#install gems
- nokogiri
- faker



#create folder - app/assets/images/autopics



#create migration file
- add bot:boolean, autopic:string to users



# run rails db:seed



#create helper method
```
def random_tweet
  user_id = User.where(bot: true).sample.id
  message = Faker::TvShows::TwinPeaks.quote
  Tweet.create!(message: message, user_id: user_id)
end
 ```


# put <%= random_tweet %> somewhere