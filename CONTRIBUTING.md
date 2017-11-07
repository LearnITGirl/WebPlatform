# Contributing to Learn IT, Girl

Learn IT, Girl web platform welcomes all contributors.

First, make sure you have `Ruby on Rails` (Rails v4.2.6, Ruby v2.3.0) and `PostgreSQL` installed. (https://gorails.com/setup)

Then, you'll need to install gem dependencies:

    bundle install

If you have any problem with `data-confirm-modal` try to manually install the gem:

		gem install data-confirm-modal

Now you can start server `rails s` and see this application in your browser on `localhost:3000`.

## Database

To setup the database

* copy config/database_template.yml to config/database.yml and fill it in using your postgreSQL's credentials
* run `rake db:setup`
* run `rake db:seed:init`
* run `rake db:seed:users` it will create a test organizer account

## Project Flow

Learn IT Girl flow can be split onto few steps (listed below). We prepared some
database seed files to make it easier for You to understand the flow and
to contribute.

* Application - `rake db:seed:applications` - `/mentor_applications/new`
  or `/mentee_applications/new`
* Application Evaluation-  `rake db:seed:evaluations` or `/organisers/dashboard`
* Matching mentors to mentees - `/mentor_to_mentee_matchers`
* Edition start
* Final evaluation (when edition ends)

## Environment Variables

Your `.env` file should contain one entry: `ACTUAL_EDITION="test"`

It will be changed in future versions.

## Pull requests

Before submitting pull request, please make sure that your changes are well tested :) Remember to also include link to the story you implemented.
