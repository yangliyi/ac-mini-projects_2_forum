namespace :dev do
  task :fake => :environment do

    puts "Creating fake data!"
    10.times do |i|
      p = Post.create( topic: Faker::App.name )
      p.content = ( Faker::Hacker.say_something_smart )
      p.user = User.first
      p.status = "published"
      p.save
    end
  end

  task :fetch_taipei_park => :environment do

    puts "fetching taipei_park"

    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=8f6fcb24-290b-461d-9d34-72ed1b3f51f0"

    raw_content = RestClient.get(url)

    data = JSON.parse( raw_content )

    data["result"]["results"].each do |p|

      TaipeiPark.create( park_id: p["_id"], name: p["ParkName"], administrativearea: p["AdministrativeArea"], location: p["Location"])

    end
  end

end