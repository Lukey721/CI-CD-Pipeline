FROM ruby:3.2.2

# Set the working directory
WORKDIR /app

# Install  dependencies 
RUN apt-get update -qq && apt-get install -y nodejs && apt-get install -y yarn

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems
RUN bundle install 

# Copy the rest of the application code
COPY . .

ENV SECRET_KEY_BASE=f2745d791fb3e17b72d569253ed57106d6d9eebdd915cf9afbbc1228a2c7f8934962c6c2e1bfbc1d1e0096d6bee537115e2cb7b04d58b2ea602827f3e3c97dba

RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose the port
EXPOSE 8080

# Run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8080"]