class EmailTemplatesController < ApplicationController
  before_action :find_email_template, only: [:edit, :update, :destroy, :deliver]

  def index
    @email_templates = EmailTemplate.all
  end

  def search
    @email_templates = EmailTemplate.search(search_template_params)
    render :index
  end

  def create
    @email_template = EmailTemplate.new(email_template_params)
    if @email_template.save
      redirect_to email_templates_path, notice: "Saved successfully!"
    else
      render :new
    end
  end

  def update
    if @email_template.update(email_template_params)
      redirect_to email_templates_path, notice: "Updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @email_template.delete
    redirect_to :back, notice: "Deleted successfully!"
  end

  def deliver
    @email_template.users.each do |user|
      EmailTemplateMailer.custom(@email_template, user).deliver
    end
    redirect_to :back, notice: "Email '#{@email_template.subject}' sent to #{@email_template.recipients.humanize}!"
  end

  private

  def email_template_params
    params.require(:email_template).permit(:subject, :body, :recipients)
  end

  def search_template_params
    params.require(:email_template).permit(:subject)
  end

  def find_email_template
    @email_template ||= EmailTemplate.find(params[:id])
  end
end