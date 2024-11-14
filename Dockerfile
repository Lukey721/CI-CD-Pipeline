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

RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose the port
EXPOSE 8080

# Run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8080"]