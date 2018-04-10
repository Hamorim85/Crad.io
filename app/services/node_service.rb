# frozen_string_literal: true

# app/services/node_service.rb
class NodeService
  def initialize(node)
    # TODO: to be later used
    # @url = node.url
    # @categories = node.categories
    @url = node # here for inital testing, shouln't be pushed
    # (if I did, I'm sry - Caio)
    visit_page
  end

  def visit_page
    p "Visiting #{@url}"
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to "http://instagram.com/#{@url}/followers"

    # Login as an user to instagram
    login(driver, 'hannaschmitz069', 'qwertz123456')

    wait = Selenium::WebDriver::Wait.new(timeout: 8) # seconds

    # Wait until instagram redirect us to the followers page
    wait.until { driver.find_element(class: '_mainc') }

    # Then we click on the FOLLOWERS link
    clickable_link = "/#{@url}/followers/"
    followers_link = driver.find_element(:css, "a[href='#{clickable_link}']")
    followers_link.click

    # Waiting until the followers popup shows up
    # (in that case, his elements shows up)
    follower_image = "a[style='width: 30px; height: 30px;']"
    wait.until { driver.find_element(:css, follower_image) }

    # Scroll the popup five times
    6.times do |i|
      puts "#{i} - Scrolling into view... "
      script = 'document.querySelector("ul div li:last-child").scrollIntoView()'
      driver.execute_script(script)
      sleep 2
    end

    # Then we try to save them
    gather_list(display_followers(driver, @url))
    sleep 5
  end

  def display_followers(driver, usr)
    list = []
    follower_image = "a[style='width: 30px; height: 30px;']"
    followers = driver.find_elements(:css, follower_image)

    followers.each do |item|
      username = item.attribute('href').scan(/https:\/\/www.instagram.com\/(.+)\//).flatten.first
      puts "#{username} - #{item.attribute('href')}"
      list << username
    end

    puts "Total followers found for #{usr}: #{list.size}"

    list
  end

  def login(driver, usr, psw)
    element = driver.find_element(name: 'username')
    element.send_keys usr
    # element.submit
    element = driver.find_element(name: 'password')
    element.send_keys psw
    element.submit
  end

  def gather_list(list)
    puts "Searching for #{list.size} profiles"

    Influencer.destroy_all

    list.each do |profile|
      research(profile)
      sleep 3
    end
  end

  def research(profile)
    puts "Saving #{profile}"
    url = "https://www.instagram.com/#{profile}?__a=1"
    # open the url, read it what gives you a huge string. then trough JSON.
    # your turn the huge string into a hash.
    page = JSON.parse(open(url).read)

    # create a new influencer in our database
    influencer = Influencer.new

    # define the attributes
    ig = page['graphql']['user']
    influencer.username = ig['username']

    email_regex = /([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/
    influencer.email = email_regex.match(ig['biography'])

    influencer.photo = ig['profile_pic_url_hd']
    influencer.bio = ig['biography']
    influencer.full_name = ig['full_name']
    influencer.external_url = ig['external_url']
    influencer.followers_count = ig['edge_followed_by']['count']
    influencer.following_count = ig['edge_follow']['count']
    influencer.media_count = ig['edge_owner_to_timeline_media']['count']
    influencer.igid = ig['id']
    influencer.verified = ig['is_verified']

    # ONly save if the user has more than 1000 followers
    influencer.save if ig['edge_followed_by']['count'].to_i > 500
  end
end
