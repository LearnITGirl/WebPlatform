# Contributing to Learn IT, Girl

Learn IT, Girl web platform welcomes all contributors.

First, make sure you have `Ruby on Rails` (we're using v 4.2.6) and `PostgreSQL` installed. (https://gorails.com/setup)

Then, you'll need to install gem dependencies:

    bundle install

If you have any problem with `data-confirm-modal` try to manually install the gem:

		gem install data-confirm-modal


and setup database:

* copy config/database_template.yml to config/database.yml and fill it in using your postgreSQL's credentials
* run `rake db:setup`.

Now you can start server `rails s` and see this application in your browser on `localhost:3000`.

## Pull requests

Before submitting pull request, please make sure that your changes are well tested :) Remember to also include link to the story you implemented.
