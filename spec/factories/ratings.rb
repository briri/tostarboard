# frozen_string_literal: true

FactoryBot.define do
  factory :rating do
    boat_type         { Faker::Lorem.unique.word }
    rating            { Faker::Number.number 3 }
    sail_plan_i       { Faker::Number.decimal 1 }
    sail_plan_j       { Faker::Number.decimal 1 }
    sail_plan_p       { Faker::Number.decimal 1 }
    sail_plan_e       { Faker::Number.decimal 1 }
    sail_plan_py      { Faker::Number.decimal 1 }
    sail_plan_ey      { Faker::Number.decimal 1 }
    displacement      { Faker::Number.decimal 1 }
    length_water_line { Faker::Number.decimal 1 }
    draft             { Faker::Number.decimal 1 }
  end
end
