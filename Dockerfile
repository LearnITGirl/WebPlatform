FROM ruby:2.3.0

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
ENV APP_DIR='/LearnITGirl'

WORKDIR ${APP_DIR}
COPY ./ ${APP_DIR}
COPY ./config/database.yml ${APP_DIR}/
RUN bundle install
RUN chmod +x ${APP_DIR}/scripts/entrypoint.sh

# ENTRYPOINT ["./scripts/entrypoint.sh"]



