# Contributing to Learn IT, Girl

Learn IT, Girl web platform welcomes all contributors.

First, make sure you have `Ruby on Rails` (we're using v 4.2.1), `PostgreSQL` and `bower` installed.

Then, you'll need to install gem dependencies:

    bundle install

and setup database:

* copy config/database_template.yml to config/database.yml and fill it in using your postgreSQL's credentials
* run `rake db:setup`.

Now you can start server `rails s` and see this application in your browser on `localhost:3000`.

## Pull requests

Before submitting pull request, please make sure that your changes are well tested :) Remember to also include link to the story you implemented.
