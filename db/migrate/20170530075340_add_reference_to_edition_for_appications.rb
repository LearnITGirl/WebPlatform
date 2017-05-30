class AddReferenceToEditionForAppications < ActiveRecord::Migration
  def change
    add_reference :mentor_applications, :edition
    add_reference :mentee_applications, :edition
  end
end
