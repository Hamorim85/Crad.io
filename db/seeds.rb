# frozen_string_literal: true

p 'Deleting influencers'
Influencer.destroy_all

p 'Adding influencers'
Influencer.create(username: 'anna.melkonyan2', followers_count: 3815, following_count: 313)
Influencer.create(username: 'vibellabonnie', full_name: 'Virgine Morangier', followers_count: 140, following_count: 702, external_url: 'wwww.katzamis.etsy.com')
Influencer.create(username: 'rebekka.corcodel', followers_count: 3213, following_count: 460)
Influencer.create(username: 'valterinhow95', followers_count: 759, following_count: 577)
Influencer.create(username: 'jujuperez', followers_count: 793, following_count: 527)
Influencer.create(username: 'brittdown', followers_count: 493, following_count: 1094)
Influencer.create(username: 'wiwmec', followers_count: 4624, following_count: 5479)
Influencer.create(username: 'mnguyenkhac', followers_count: 740, following_count: 1187)
Influencer.create(username: 'elbaml', followers_count: 257, following_count: 343)
Influencer.create(username: 'cembycem', followers_count: 7309, following_count: 465)

p 'Deleting nodes'
Node.destroy_all

p 'Adding nodes'
wwf = Node.create(name: 'WWF Brasil', url: 'wwfbrasil')
greenpeace = Node.create(name: 'Greenpeace Brasil', url: 'greenpeacebrasil')

p 'Deleting categories'
Category.destroy_all

p 'Adding categories'
animal_rights = Category.create(name: 'Animal Rights')
enviroment = Category.create(name: 'Enviroment')

p 'Adding categories to nodes'
wwf.categories << animal_rights << enviroment
greenpeace.categories << enviroment

# Adding both nodes to first 4 influencers
p 'Adding matches to users'
Influencer.first(4).each do |influencer|
  influencer_category = InfluencerCategory.new(
    category: wwf.category,
    node: [wwf, greenpeace]
  )
  influencer.influencer_categories << influencer_category
  influencer.save
end

# Adding one random node to the last 6
Influencer.last(6).each do |influencer|
  influencer_category = InfluencerCategory.new(
    category: wwf.category,
    node: [Node.all.sample]
  )
  influencer.influencer_categories << influencer_category
  influencer.save
end
