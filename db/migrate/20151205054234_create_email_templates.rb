class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :subject, null: false, unique: true
      t.text :body, null: false
      t.integer :recipients, null: false, default: 0
      t.timestamps null: false
    end
  end
end