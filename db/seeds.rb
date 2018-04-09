# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Influencer.destroy_all

influencers = [
{
  username: "anna.melkonyan2", followers_count: 3815, following_count: 313
  },
{
  username: "vibellabonnie", full_name: "Virgine Morangier", followers_count: 140, following_count: 702, external_url: "wwww.katzamis.etsy.com"
  },
{
  username: "rebekka.corcodel", followers_count: 3213, following_count: 460
  },
{
  username: "valterinhow95", followers_count: 759, following_count: 577
  },
{
  username: "jujuperez", followers_count: 793, following_count: 527
  },
{
  username: "brittdown", followers_count: 493, following_count: 1094
  },
{
  username: "wiwmec", followers_count: 4624, following_count: 5479
  },
{
  username: "mnguyenkhac", followers_count: 740, following_count: 1187
  },
{
  username: "elbaml", followers_count: 257, following_count: 343
  },
{
  username: "cembycem", followers_count: 7309, following_count: 465
  },
]

influencers.each { |influencer| Influencer.create(influencer) }

