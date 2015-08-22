class SubscribeController < ApplicationController
    def index
    end
    def subscribe
        begin
        @list_id = 'fe525f1cb2'
        gb = Gibbon::Request.new
        gb.lists(@list_id).members.create(body: {
          email_address: params[:list][:email], 
          status: "subscribed", 
          merge_fields: {FNAME: params[:list][:first_name], LNAME: params[:list][:last_name]}})
        rescue Gibbon::MailChimpError => e
            flash[:alert] =  e.detail
        else
           flash[:notice] = 'Thank you for subscribing!'
        end
        redirect_to subscribe_path
    end
end