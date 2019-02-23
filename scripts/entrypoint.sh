set -e

set +x

# Start Rails API service
rake db:setup
rake db:seed:init
rake db:seed:users
# rails s