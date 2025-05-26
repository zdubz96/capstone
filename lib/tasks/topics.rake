namespace :topics do
  desc "Generate topics"
  task generate_topics: :environment do
    Topic.create!(
            topic: "General knowlege"
          )
    Topic.create!(
            topic: "STEM (Science, Technology, Enginnering, Math)"
          )
    Topic.create!(
            topic: "Entertainment"
          )
    Topic.create!(
            topic: "Business"
          )
  end
end
