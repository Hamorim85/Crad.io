class Influencer < ApplicationRecord

  def follow_ratio
    self.followers_count / self.following_count.to_f
  end
end
