class Quote < ActiveRecord::Base
  def self.get_quote
    response = HTTParty.get "https://api.github.com/zen", :headers=> { "User-Agent" => ENV['username'] }
    response.body
  end
end
