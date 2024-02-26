# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'ad@min',
   password: '111111'
)

tanaka.id = Member.find_or_create_by!(email: "tanaka@example.com") do |member|
  member.last_name = "田中"
  member.first_name = "太郎"
  member.display_name = "たなか"
  member.is_active = true
  member.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

sato.id = Member.find_or_create_by!(email: "sato@example.com") do |member|
  member.last_name = "佐藤"
  member.first_name = "二郎"
  member.display_name = "さとう"
  member.is_active = true
  member.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

suzuki.id = Member.find_or_create_by!(email: "suzuki@example.com") do |member|
  member.last_name = "鈴木"
  member.first_name = "三郎"
  member.display_name = "すずき"
  member.is_active = true
  member.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

kita.id = Region.find_or_create_by!(name: "熊本市北区") 

nishi.id = Region.find_or_create_by!(name: "熊本市西区") 

higashi.id = Region.find_or_create_by!(name: "熊本市東区") 

Group.find_or_create_by!(name: "北区体育館") do |group|
  group.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-group1.jpg"), filename:"sample-group1.jpg")
  group.region_id = kita.id
  group.introduction = "(利用可能時間) 9:00~22:00 (駐車場)有り"
  group.address = 
end