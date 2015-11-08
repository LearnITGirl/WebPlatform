class SubscriptionController < ApplicationController
	def create
        begin
        @list_id = ENV["MAILCHIMP_LIST"]
        gb = Gibbon::Request.new
        gb.lists(@list_id).members.create(body: {
          email_address: params[:list][:email], 
          status: "subscribed"})
        rescue Gibbon::MailChimpError => e
            flash[:alert] =  e.detail
        else
           flash[:notice] = 'Thank you for subscribing!'
        end
        return redirect_to root_path
    end
end
