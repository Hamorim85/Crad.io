# frozen_string_literal: true

# app/services/node_service.rb
class NodeService
  def initialize(node)
    @node = node
    visit_page
  end

  private

  def visit_page
    p "Visiting #{@node.url}"
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to "http://instagram.com/#{@node.url}/followers"

    # Login as an user to instagram
    login(driver, 'hannaschmitz069', 'qwertz123456')

    wait = Selenium::WebDriver::Wait.new(timeout: 8) # seconds

    # Wait until instagram redirect us to the followers page
    wait.until { driver.find_element(class: '_mainc') }

    # Then we click on the FOLLOWERS link
    clickable_link = "/#{@node.url}/followers/"
    followers_link = driver.find_element(:css, "a[href='#{clickable_link}']")
    followers_link.click

    # Waiting until the followers popup shows up
    # (in that case, his elements shows up)
    follower_image = "a[style='width: 30px; height: 30px;']"
    wait.until { driver.find_element(:css, follower_image) }

    # Scroll until timeout
    last_child = ''
    scroll = 'document.querySelector("ul div li:last-child").scrollIntoView()'
    loop do
      break if last_child == driver.find_element(:css, 'ul div li:last-child')
      last_child = driver.find_element(:css, 'ul div li:last-child')
      driver.execute_script(scroll)
      count = 0
      puts "#{count} - Scrolling into view... "

      while last_child == driver.find_element(:css, 'ul div li:last-child')
        count += 1
        sleep 1
        break if count >= 30
      end
    end

    # Then we try to save them
    gather_list(display_followers(driver, @node.url))
    sleep 5
  end

  def display_followers(driver, usr)
    followers_list = []
    follower_image = "a[style='width: 30px; height: 30px;']"
    followers = driver.find_elements(:css, follower_image)

    followers.each do |item|
      username = item.attribute('href').scan(/https:\/\/www.instagram.com\/(.+)\//).flatten.first
      puts "#{username} - #{item.attribute('href')}"
      followers_list << username
    end

    puts "Total followers found for #{usr}: #{followers_list.size}"

    followers_list
  end

  def login(driver, usr, psw)
    p "Logging in as #{usr}..."
    element = driver.find_element(name: 'username')
    element.send_keys usr
    # element.submit
    element = driver.find_element(name: 'password')
    element.send_keys psw
    element.submit
  end

  def gather_list(followers_list)
    puts "Grabing info from #{followers_list.size} profiles..."

    followers_list.each do |username|
      save_info(username)
    end
  end

  def save_info(username)
    influencer = Influencer.find_or_initialize_by(username: username)
    influencer.save unless influencer.persisted?

    @node.categories.each do |category|
      category_match = InfluencerCategory.find_or_initialize_by(category: category, influencer: influencer)
      next if category_match.node_ids.include?(@node.id)
      category_match.node_ids << @node.id
      category_match.influencer = influencer
      category_match.save
    end
  end
end
