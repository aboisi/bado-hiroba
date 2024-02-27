# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

tanaka = Member.find_or_create_by!(email: "tanaka@example.com") do |member|
  member.password = "password"
  member.last_name = "田中"
  member.first_name = "太郎"
  member.display_name = "たなか"
  member.is_active = true
  member.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

sato = Member.find_or_create_by!(email: "sato@example.com") do |member|
  member.password = "password"
  member.last_name = "佐藤"
  member.first_name = "二郎"
  member.display_name = "さとう"
  member.is_active = true
  member.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

suzuki = Member.find_or_create_by!(email: "suzuki@example.com") do |member|
  member.password = "password"
  member.last_name = "鈴木"
  member.first_name = "三郎"
  member.display_name = "すずき"
  member.is_active = true
  member.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

kita = Region.find_or_create_by!(name: "熊本市北区")

nishi = Region.find_or_create_by!(name: "熊本市西区")

higashi = Region.find_or_create_by!(name: "熊本市東区")

kitaichi = Group.find_or_create_by!(name: "北区第一体育館") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-group1.jpg"), filename:"sample-group1.jpg")
  group.region_id = kita.id
  group.introduction = "(利用可能時間) 9:00~22:00 (駐車場)有り"
  group.address = "熊本市北区１丁目"
  group.telephone_number = "000-000-0000"
end

kitani = Group.find_or_create_by!(name: "北区第二体育館") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-group2.jpg"), filename:"sample-group2.jpg")
  group.region_id = kita.id
  group.introduction = "(利用可能時間) 9:00~22:30 (駐車場)有り"
  group.address = "熊本市北区２丁目"
  group.telephone_number = "111-111-1111"
end

nishiichi = Group.find_or_create_by!(name: "西区体育館") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-group3.jpg"), filename:"sample-group3.jpg")
  group.region_id = nishi.id
  group.introduction = "(利用可能時間) 8:30~21:00 (駐車場)有り"
  group.address = "熊本市西区１丁目"
  group.telephone_number = "222-222-2222"
end

higashiichi = Group.find_or_create_by!(name: "東区体育館") do |group|
  group.group_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-group4.jpg"), filename:"sample-group4.jpg")
  group.region_id = nishi.id
  group.introduction = "(利用可能時間) 8:00~21:00 (駐車場)有り"
  group.address = "熊本市東区１丁目"
  group.telephone_number = "333-333-3333"
end

GroupUser.find_or_create_by!(member_id: tanaka.id, group_id: kitaichi.id)

GroupUser.find_or_create_by!(member_id: tanaka.id, group_id: nishiichi.id)

GroupUser.find_or_create_by!(member_id: sato.id, group_id: kitani.id)

GroupUser.find_or_create_by!(member_id: suzuki.id, group_id: nishiichi.id)

Post.find_or_create_by!(member_id: tanaka.id, group_id: kitaichi.id) do |post|
  post.body = "よろしくお願いします。"
end

Post.find_or_create_by!(member_id: sato.id, group_id: kitani.id) do |post|
  post.body = "来週の日曜日の13:00からバドミントンできます。"
end


Post.find_or_create_by!(member_id: suzuki.id, group_id: nishiichi.id) do |post|
  post.body = "今週19:00からできる方一緒にしましょう！"
end
