require "spec_helper"

describe Api::MentorApplicationsController, type: :controller do
  describe "POST /api/mentor_applications" do
    before do
      ActionMailer::Base.deliveries.clear
    end

    it "should create new mentor application for proper params" do
      applications_number = MentorApplication.count

      expect(ActionMailer::Base.deliveries.count).to eq(0)

      params = Fabricate.to_params(:mentor_application, programming_languages: [ProgrammingLanguage.pluck(:slug).sample])
      params = params.each{|k, v| params[k] = v.to_s}

      post :create, format: :json, application: params, step: 5, steps: 5

      expect(response).to be_success
      expect(response.status).to eq 200

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include MentorApplication.last.email
      expect(MentorApplication.count).to eq(applications_number + 1)
    end
  end
end
