namespace :topics do
  desc "Generate topics"
  task generate_topics: :environment do
    Topic.create!(
            topic: "Math"
          )
  end
end
