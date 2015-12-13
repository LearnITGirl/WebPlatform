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
          status: 422, class: 'danger',
          msg: e.detail.gsub(/Use PUT to insert or update list members./,'')
        }
      else
        response = {status: 201, class: 'success', msg: 'Thank you for subscribing!' }
      end
    else
      response = {status: 422, class: 'danger', msg: @newsletter.errors.full_messages.join(", ")}
    end
    render json: response, status: response[:status]
  end
end
