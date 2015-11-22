class SubscriptionController < ApplicationController
	def create
        begin
        @list_id = ENV["MAILCHIMP_LIST"]
        gb = Gibbon::Request.new
        gb.lists(@list_id).members.create(body: {
          email_address: params[:list][:email], 
          status: "subscribed"})
        rescue Gibbon::MailChimpError => e
            response = { :status => 'error', :class => 'danger', :msg => e.detail.gsub(/Use PUT to insert or update list members./,'') } 
        else
            response = { :status => 'success', :class => 'success', :msg => 'Thank you for subscribing!' } 
        end
        respond_to do |format|
          format.json { render :json => response }
        end
    end
end
