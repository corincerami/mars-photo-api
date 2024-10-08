# Use an official Ruby image that includes Ruby 3.2.2
FROM ruby:3.2.2

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock /app/

# Install dependencies, such as gems listed in the Gemfile
RUN bundle install

# Copy the rest of the application code into the container
COPY . /app

# Install Node.js and Yarn to handle JavaScript dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm && npm install --global yarn

# Set up PostgreSQL client dependencies
RUN apt-get install -y postgresql-client

# Expose port 3000 to the outside world
EXPOSE 3000

# Run the Rails server when the container starts
CMD ["rails", "server", "-b", "0.0.0.0"]
