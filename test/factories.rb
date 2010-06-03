Factory.define :workshop do |f|
  f.sequence(:title) { |n| "title_#{n}" }
  f.sequence(:description) { |n| "description_#{n}" }
  f.sequence(:short_description) { |n| "short_description_#{n}" }
end

Factory.define :attendee do |f|
  f.sequence(:name) { |n| "name_#{n}" }
  f.sequence(:phone) { |n| "11111111#{n}" }
  f.sequence(:email) { |n| "email#{n}@email.com" }
  f.association :workshop
end
