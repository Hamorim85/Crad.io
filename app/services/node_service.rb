# frozen_string_literal: true

# app/services/node_service.rb
class NodeService
  def initialize(node)
    @url = node.url
    @categories = node.categories
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

  def research(username)
    puts "Saving #{username}"
    url = "https://www.instagram.com/#{username}?__a=1"
    # open the url, read it what gives you a huge string. then trough JSON.
    # your turn the huge string into a hash.

    # create a new influencer in our database
    influencer = Influencer.find_by_username(username) || Influencer.new

    # TODO: Ask Matheus with sould let AR handle this or just check the id before
    # @categories.each do |category|
    #   influencer.influencer_categories << InfluencerCategory.new(node: node, category: category)
    # end


    if !influencer.persisted? || (Date.today - influencer.updated_at) < 30.days
      page = JSON.parse(open(url).read)

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

      # Only save if the user has more than 1000 followers
      influencer.save if ig['edge_followed_by']['count'].to_i > 5000
    end
  end
end



























# TODO: Keep instroducing new code into the service

# require "open-uri"
# require "json"
# require 'selenium-webdriver'
#
#
#
# # Install selenium-webdriver
# # Install brew install chromedriver to allow selenium to open chrome
# task(:visit_page => :environment) do
#   puts "Starting..."
#   visitpage("nanook_otn")
# end
#
# # user_login = "hannaschmitz069"
# # user_password = "qwertz123456"
#
# def visitpage(node_to_research)
#   # TODO: change node_to_research from a url to a Node instance 'node'
#   driver = Selenium::WebDriver.for :chrome
#   driver.navigate.to "http://instagram.com/#{node_to_research}/followers"
#
#   # Login as an user to instagram
#   login(driver, "hannaschmitz069", "qwertz123456")
#
#   wait = Selenium::WebDriver::Wait.new(timeout: 8) # seconds
#
#
#   # Wait until instagram redirect us to the followers page
#   wait.until { driver.find_element(class: '_mainc') }
#
#
#   # Then we click on the FOLLOWERS link
#   clickable_link = "/#{node_to_research}/followers/"
#   followers_link = driver.find_element(:css, "a[href='#{clickable_link}']")
#   followers_link.click
#
#   # Waiting until the followers popup shows up (in that case, his elements shows up)
#   wait.until { driver.find_element(:css, "a[style='width: 30px; height: 30px;']") }
#
#
#   # Scroll the popup 3999 times
#   last_child = nil
#   4000.times do |i|
#     break if last_child == driver.find_element(:css, 'ul div li:last-child')
#     last_child = driver.find_element(:css, 'ul div li:last-child')
#
#     puts "#{i} - Scrolling into view... "
#     driver.execute_script('document.querySelector("ul div").querySelector("li:last-child").scrollIntoView()')
#
#     count = 0;
#
#     while last_child != driver.find_element(:css, 'ul div li:last-child')
#       count += 1;
#       sleep 1
#       if count >= 30
#          # 30 seconds
#          puts "=================="
#          puts "THIS IS THE LAST CHILD WHO BROKE =>"
#          puts last_child
#          puts "=================="
#          break
#       end
#     end
#   end
#
#
#   # Then we try to save them
#   gather_list(display_followers(driver, node_to_research))
#   sleep 5
# end
#
#
#
# def display_followers(driver, usr)
#   list = []
#   followers = driver.find_elements(:css, "a[style='width: 30px; height: 30px;']")
#
#   followers.each do |item|
#     username = item.attribute("href").scan(/https:\/\/www.instagram.com\/(.+)\//).flatten.first
#     puts "#{username} - #{item.attribute("href")}"
#     list << username
#   end
#
#   puts "Total followers found for #{usr}: #{list.size}"
#
#
#   return list
# end
#
#
# def login(driver, usr, pw)
#   element = driver.find_element(name: 'username')
#   element.send_keys usr
#   # element.submit
#   element = driver.find_element(name: 'password')
#   element.send_keys pw
#   element.submit
# end
#
#
#
# def gather_list(list)
#   puts "Searching for #{list.size} profiles"
#
#   Influencer.destroy_all
#
#   list.each do |username|
#     research(username)
#     sleep 3
#   end
# end
#
#
# def research(username)
#   puts "Saving #{username}"
#   url = "https://www.instagram.com/#{username}?__a=1"
#   #open the url, read it what gives you a huge string. then trough JSON.
#   #your turn the huge string into a hash.
#
#   #create a new influencer in our database
#   influencer = Influencer.find_by_username(username) || Influencer.new
#
#   if !influencer.persisted? || (Date.today - influencer.updated_at) < 30.days
#     page = JSON.parse(open(url).read)
#
#     # define the attributes
#     ig = page["graphql"]["user"]
#     influencer.username = ig["username"]
#     influencer.email = /([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/.match(ig["biography"])
#     influencer.photo = ig["profile_pic_url_hd"]
#     influencer.bio = ig["biography"]
#     influencer.full_name = ig["full_name"]
#     influencer.external_url = ig["external_url"]
#     influencer.followers_count = ig["edge_followed_by"]["count"]
#     influencer.following_count = ig["edge_follow"]["count"]
#     influencer.media_count = ig["edge_owner_to_timeline_media"]["count"]
#     influencer.igid = ig["id"]
#     influencer.verified = ig["is_verified"]
#
#     # ONly save if the user has more than 1000 followers
#     influencer.save if ig["edge_followed_by"]["count"].to_i > 5000
#   end
#
#   # TODO: Ask Matheus with sould let AR handle this or just check the id before
#   # TODO:
#   # node.categories.each do |category|
#   # influencer.influencer_categories << InfluencerCategory.new(node: node, category: category)
#   # end
#
# end
