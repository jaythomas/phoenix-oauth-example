#!/bin/sh
set -e

# Ensure the app's dependencies are installed
mix deps.get

# Prepare Dialyzer if the project has Dialyxer set up
if mix help dialyzer >/dev/null 2>&1
then
  echo "\nFound Dialyxer: Setting up PLT..."
  mix do deps.compile, dialyzer --plt
else
  echo "\nNo Dialyxer config: Skipping setup..."
fi

# Install node modules
echo "\nInstalling nodejs modules..."
npm install

# Wait for Postgres to become available.
sleep 5 # TODO: poll for a connection instead of setting up a race condition
#until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
  #>&2 echo "Postgres is unavailable - sleeping"
  #sleep 1
#done

echo "\nPostgres is available: continuing with database setup..."

# Potentially Set up the database
mix ecto.create
mix ecto.migrate

# Check that the installation was successful by running tests
echo "\nTesting the installation..."
mix test

# Start the phoenix web server
echo "\n Launching Phoenix web server..."
mix phoenix.server
