class FeedMailer < ApplicationMailer
  def parsing_products_completed user, feed
    @user = user
    @feed = feed
    mail subject: "Product feed parsing completed",
         to:      user.email ,
         from:    "no-reply@example.com"
  end
end
