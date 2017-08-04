require "spec_helper"

describe Api::MenteeApplicationsController, type: :controller do
  describe "POST /api/mentee_applications" do
    before do
      ActionMailer::Base.deliveries.clear
    end

    it "should create new mentee application for proper params" do
      applications_number = MenteeApplication.count

      expect(ActionMailer::Base.deliveries.count).to eq(0)

      params = Fabricate.to_params(:mentee_application, programming_language: ProgrammingLanguage.pluck(:slug).sample)
      params = params.each{|k, v| params[k] = v.to_s}

      post :create, format: :json, application: params, step: 3, steps: 3

      expect(response).to be_success
      expect(response.status).to eq 200

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include MenteeApplication.last.email
      expect(MenteeApplication.count).to eq(applications_number + 1)
    end
  end
end
