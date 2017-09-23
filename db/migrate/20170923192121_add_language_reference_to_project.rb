class AddLanguageReferenceToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :programming_language
  end
end
