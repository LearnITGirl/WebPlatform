# Preview all emails at http://localhost:3000/rails/mailers/missing_persons_mailer
class MissingPersonsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/missing_persons_mailer/MissingMentor
  def MissingMentor
    MissingPersonsMailer.MissingMentor
  end

end
