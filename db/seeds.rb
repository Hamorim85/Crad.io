# frozen_string_literal: true

p 'Deleting join tables'
InfluencerCategory.destroy_all
NodeCategory.destroy_all

p 'Deleting influencers'
Influencer.destroy_all

p 'Deleting nodes'
Node.destroy_all

p 'Deleting categories'
Category.destroy_all

p 'Adding influencers'
Influencer.create(username: 'anna.melkonyan2',  followers_count: 3815,  following_count: 313)
Influencer.create(username: 'vibellabonnie',    followers_count: 140,   following_count: 702, full_name: 'Virgine Morangier', external_url: 'wwww.katzamis.etsy.com')
Influencer.create(username: 'rebekka.corcodel', followers_count: 3213,  following_count: 460)
Influencer.create(username: 'valterinhow95',    followers_count: 759,   following_count: 577)
Influencer.create(username: 'jujuperez',        followers_count: 793,   following_count: 527)
Influencer.create(username: 'brittdown',        followers_count: 493,   following_count: 1094)
Influencer.create(username: 'wiwmec',           followers_count: 4624,  following_count: 5479)
Influencer.create(username: 'mnguyenkhac',      followers_count: 740,   following_count: 1187)
Influencer.create(username: 'elbaml',           followers_count: 257,   following_count: 343)
Influencer.create(username: 'cembycem',         followers_count: 7309,  following_count: 465)

p 'Adding nodes'
wwf = Node.create(name: 'WWF Brasil', url: 'wwfbrasil')
greenpeace = Node.create(name: 'Greenpeace Brasil', url: 'greenpeacebrasil')

p 'Adding categories'
animal_rights = Category.create(name: 'Animal Rights')
enviroment = Category.create(name: 'Enviroment')

p 'Adding categories to nodes'
wwf.categories << animal_rights << enviroment
greenpeace.categories << enviroment

# Adding both nodes to first 4 influencers
p 'Adding matches to users'
Influencer.first(4).each do |influencer|
  enviroment_match = InfluencerCategory.new(category: enviroment)
  enviroment_match.nodes << wwf
  enviroment_match.nodes << greenpeace
  influencer.influencer_categories << enviroment_match
  influencer.save

  animal_rights_match = InfluencerCategory.new(category: animal_rights)
  animal_rights_match.nodes << wwf
  influencer.influencer_categories << animal_rights_match
  influencer.save
end

# Adding one random node to the last 6
Influencer.last(6).each do |influencer|
  enviroment_match = InfluencerCategory.new(category: enviroment)
  enviroment_match.nodes << greenpeace
  influencer.influencer_categories << enviroment_match
  influencer.save
end
