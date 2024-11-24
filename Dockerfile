FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  yarn \
  build-essential \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Install Bundler and Rails dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

# Copy the rest of the application code
COPY . ./

# Set environment variables (adjust RAILS_MASTER_KEY if necessary)
ENV RAILS_SECRET_KEY_BASE=${RAILS_SECRET_KEY_BASE}
ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}

# Set environment variable for Rails environment
ENV RAILS_ENV=production

# Precompile assets in production
RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Set the entry point for the application
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]