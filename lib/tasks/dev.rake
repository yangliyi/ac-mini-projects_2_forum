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
end