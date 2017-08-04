require 'spec_helper'

describe MenteeApplicationMailer do
    describe 'confirm application email' do
      let!(:mentee_application) { Fabricate(:mentee_pending_application) }

      it "should be sent properly for mentee application" do
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        MenteeApplicationMailer.confirm_application(mentee_application).deliver_now
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
end
