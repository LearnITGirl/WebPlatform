require 'spec_helper'

describe MentorApplicationMailer do
    describe 'confirm application email' do
      let!(:mentor_application) { Fabricate(:mentor_pending_application) }

      before do
        ActionMailer::Base.deliveries.clear
      end

      it "should be sent properly for mentor application" do
        expect(ActionMailer::Base.deliveries.count).to eq(0)
        MentorApplicationMailer.confirm_application(mentor_application).deliver_now
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
end
