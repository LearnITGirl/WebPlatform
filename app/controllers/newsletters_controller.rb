class NewslettersController < ApplicationController

  def create
    @newsletter = Newsletter.new(email: params[:email])
    if @newsletter.save
      begin
        @list_id = ENV["MAILCHIMP_LIST"]
        gb = Gibbon::Request.new
        gb.lists(@list_id).members.create(
          body: {
            email_address: params[:email],
            status: "subscribed"
          }
        )
      rescue Gibbon::MailChimpError => e
        response = {
          status: 'error', class: 'danger',
          msg: e.detail.gsub(/Use PUT to insert or update list members./,'')
        }
      else
        response = {status: 'success', class: 'success', msg: 'Thank you for subscribing!' }
      end
    else
      response = {status: 'error', class: 'danger', msg: @newsletter.errors.full_messages.join(", ")}
    end
    render json: response
  end
end
