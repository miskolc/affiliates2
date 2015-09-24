class ParserWorker
  include Sidekiq::Worker

  def perform(feed_id)
    feed = Feed.find feed_id
    feed.save_products
    FeedMailer.parsing_products_completed(feed.user, feed).deliver
  end 

end
