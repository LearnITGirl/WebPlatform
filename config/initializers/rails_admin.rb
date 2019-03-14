RailsAdmin.config do |config|
  config.main_app_name = ["Learn IT Girl"]

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.try(:organizer?)
  end

  config.included_models = ["ProgrammingLanguage", "Badge", "Edition", "User",
                            "MenteeApplication", "MentorApplication", "Week",
                            "MenteeMidtermEvaluation", "MentorMidtermEvaluation", "Project"]

  config.model 'User' do
    list do
      scopes [:participants]
      field :first_name
      field :last_name
      field :email
      field :country
      field :role
      field :registration_token do
        label "Registered"
        pretty_value do
          bindings[:object].registration_token.nil? ? "yes" : "no"
        end
      end
    end

    show do
      include_all_fields
      exclude_fields :crypted_password, :salt, :program_country, :country, :last_login_at, :last_logout_at,
                     :last_login_from_ip_address, :registration_token
    end
  end

  config.model MenteeApplication do
    list do
      field :first_name
      field :last_name
      field :email
      field :state
    end
  end

  config.model Project do
    [edit, show, list].each do
      include_all_fields
      exclude_fields :language
    end
  end

  config.model MentorApplication do
    list do
      field :first_name
      field :last_name
      field :email
      field :state
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    show
    edit do
      if (ENV["APPLICATION_EDITION_DISABLED"])
        except ['MentorMidtermEvaluation', 'MenteeMidtermEvaluation']
      end
    end
    delete do
      except ['MentorApplication', 'MenteeApplication', 'MentorMidtermEvaluation', 'MenteeMidtermEvaluation']
    end
    show_in_app
    #export
    #bulk_delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
