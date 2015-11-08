class SubscriptionController < ApplicationController
	def index
    end
    def create
        begin
        @list_id = 'fe525f1cb2'
        gb = Gibbon::Request.new
        gb.lists(@list_id).members.create(body: {
          email_address: params[:list][:email], 
          status: "subscribed"})
        rescue Gibbon::MailChimpError => e
            flash[:alert] =  e.detail
        else
           flash[:notice] = 'Thank you for subscribing!'
        end
        return redirect_to subscription_index_path
    end
end
