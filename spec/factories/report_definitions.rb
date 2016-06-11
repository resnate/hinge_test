FactoryGirl.define do

  factory :survey_definition do

    name { Faker::Company.bs }
    week_indices { Random.rand(1..3).times.map{Random.rand(0..12)} }
    lateness_allowed { [7, 10, 14].sample.days }
    format do
      Random.rand(1..10).times.map do
        {
            name: Faker::Internet.slug,
            required: [true, false].sample,
            type: %w(integer string boolean).sample
        }
      end

    end

  end

end