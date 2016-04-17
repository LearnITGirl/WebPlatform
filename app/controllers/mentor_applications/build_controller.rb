class MentorApplications::BuildController < ApplicationController
  include Wicked::Wizard

  steps :personal_information, :experience, :programming_experience, :details, :done

  def show
    @mentor = MentorApplication.find_by(id: params[:mentor_application_id])
    return (redirect_to root_path, notice:  "Incomplete applications are deleted after 24 hours. Please apply again.") unless @mentor

    case step
    when :done
      return redirect_to root_path, notice: "Thank you for your application!"
    else
      return redirect_to root_path if @mentor.build_step.to_s == "done"
    end

    render_wizard
  end

  def update
    @mentor = MentorApplication.find_by(id: params[:mentor_application_id])
    return (redirect_to root_path, notice:  "Incomplete applications are deleted after 24 hours. Please apply again.") unless @mentor

    case step
    when :experience
      @mentor.update_attributes(mentor_params.merge({mentee_level: params[:mentee_level]}))
    when :programming_experience
      @mentor.update_attributes(mentor_params.merge({programming_languages: (params[:programming_languages] || [])}))
    when :details
      if @mentor.update_attributes(mentor_params.merge({engagements: params[:engagements], sources: params[:sources]}))
        index = @mentor.programming_languages.index("other")
        if index
          @mentor.programming_languages[index] = @mentor.other_programming_language
          @mentor.save
        end
        @mentor.update_column :build_step, :done
        MentorApplicationMailer.confirm_application(@mentor).deliver_now
      end
    else
      @mentor.update_attributes(mentor_params)
    end

    render_wizard @mentor
  end

  def mentor_params
    param = params.require(:mentor_application).permit(
      :first_name, :last_name, :country, :email, :gender, :time_zone, :motivation,
      :english_level, :experienced, :mentor_experience, :background, :git,
      :programming_experience, :sources, :application_idea, :concept_explanation,
      :engagements, :program_country, :other_programming_language
    ).merge({build_step: step})
    param[:time_availability] = params[:mentor_application][:time_availability].to_i if params[:mentor_application][:time_availability].present?
    param
  end
end
