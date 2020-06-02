FROM redmine

COPY configuration.yml /usr/src/redmine/config/configuration.yml

RUN apt-get update
RUN apt-get install -y unzip vim build-essential ruby-dev net-tools
RUN bundle install --without development test

EXPOSE 3000