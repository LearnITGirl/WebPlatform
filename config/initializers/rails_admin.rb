RailsAdmin.config do |config|
  config.main_app_name = ["Learn IT Girl"]

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.try(:organizer?)
  end

  config.included_models = ["ProgrammingLanguage", "Badge", "Edition", "User",
                            "MenteeApplication", "MentorApplication", "Week"]

  config.model 'User' do
    list do
      field :first_name
      field :last_name
      field :email
      field :country
      field :role
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    show
    edit do
      if( YAML.load(ENV["APPLICATION_EDITION_DISABLED"] || true) )
        except ['MentorApplication', 'MenteeApplication']
      end
    end
    delete do
      except ['MentorApplication', 'MenteeApplication']
    end
    show_in_app
    #export
    #bulk_delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
