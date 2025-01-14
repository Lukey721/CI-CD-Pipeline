# Ruby setup
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  yarn \
  build-essential \
  libpq-dev \
  libnss3 libgconf-2-4\
  && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Install Bundler and Rails dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Copy the rest of the application code
COPY . ./

# Set environment variables (adjust RAILS_MASTER_KEY if necessary)


# Tell Rails to serve static files directly from the public directory
ENV RAILS_SERVE_STATIC_FILES=true

# Set environment variable for Rails environment
ENV RAILS_ENV=production

# Precompile assets in production
RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Set the entry point for the application
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
