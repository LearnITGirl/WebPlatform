# Contributing to Learn IT, Girl

Learn IT, Girl web platform welcomes contributors, and pull requests are very welcome.

First, make sure you have `Ruby on Rails` (we're using v 4.2.0), `PostgreSQL` and `bower` installed.

Then, you'll need to install gem dependencies:

    bundle install

and setup database:

* copy config/database_template.yml to config/database.yml and fill it in using your postgreSQL's credentials
* run `rake db:setup`.

Now you can start server `rails s` and see this application in your browser on `localhost:3000`.

## Pull requests

Please make sure that your branch starts with `id` of the story you want to implement e.g: `123_initialize_app`. 

Before submitting pull request, ensure that your changes are well tested :) 
