class AddGdprConsentToApplications < ActiveRecord::Migration
  def up
    add_column :mentee_applications, :gdpr_consent, :boolean, default: false
    add_column :mentor_applications, :gdpr_consent, :boolean, default: false
  end

  def remove
    remove_column :mentee_applications, :gdpr_consent
    remove_column :mentor_applications, :gdpr_consent
  end
end
