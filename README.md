# Dennis

## INSTALL DEPENDENCIES
  _You need Ruby installed_
  2. Brew - `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  3. Node & NPM - https://nodejs.org/en/download/
  4. Erlang & Elixir - `brew install elixir`
  5. Bower - `npm install -g bower`
  6. Phoenix - http://www.phoenixframework.org/docs/installation#section-phoenix
  7. Postgres - http://postgresapp.com/ _Add Postgres account_

## INSTALL PROJECT DEPENDENCIES (inside project's folder)
  1. Hex - `mix local.hex`
  2. Brunch, etc. - `npm install`
  3. Hexes (Elixir gems) - `mix deps.get`
  4. Javascript tools - `bower install`

## PROJECT SETUP AND RUN
  1. Compile comeonin - `mix deps.compile comeonin`
  _This dependency needs to be compiled separately_
  2. Create DB - `mix ecto.create`
  3. Run migrations - `mix ecto.migrate`
  4. Run project - `iex -S mix phoenix.server`

---

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
