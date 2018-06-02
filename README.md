# Phoenix Oauth Example

This is a simple topic/discussion board that authenticates users with Github oauth.

## Configure and Install

First, create a github oauth application: https://github.com/settings/developers
You will need to give github an "Authorization callback URL", the url where github will redirect after a user logs into GitHub.
For local testing and development, give it the URL `http://localhost:4000/auth/github/callback`.
The rest of the fields can say whatever your heart desires.

Next, define some environment variables in your shell or put them in a `.env` file in the root of the project.
`docker-compose.yml` will feed these environment variables into the phoenix container when starting it up.
The secret key bases are random strings.
The Ueberauth client ID and secret key are the strings given to you by GitHub when creating the oauth application.

```sh
DISCUSS_PROD_SECRET_KEY_BASE="..."
DISCUSS_SECRET_KEY_BASE="..."
DISCUSS_UEBERAUTH_CLIENT_ID="..."
DISCUSS_UEBERAUTH_SECRET="..."
```

Now build and start the containers.
This method requires docker and docker-compose.
Otherwise have fun installing postgres and your system.

```sh
make build # build the phoenix container
docker-compose up
```
