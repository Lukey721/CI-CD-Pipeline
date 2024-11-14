FROM ruby:3.2.2

# Set the working directory
WORKDIR /app

# Install  dependencies 
RUN apt-get update -qq && apt-get install -y nodejs

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems
RUN bundle install 

# Copy the rest of the application code
COPY . .

# Expose the port
EXPOSE 8080

#run app
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "$PORT"]
