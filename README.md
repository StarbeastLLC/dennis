# Dennis

*INSTALL DEPENDENCIES*
  RVM & Ruby - `gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3` and `\curl -sSL https://get.rvm.io | bash -s stable --ruby`
  Brew - `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  Node & NPM - https://nodejs.org/en/download/
  Erlang & Elixir - `brew install elixir`
  Bower - `npm install -g bower`
  Phoenix - http://www.phoenixframework.org/docs/installation#section-phoenix
  Postgres - http://postgresapp.com/

*POSTGRES CONFIG* (no `psql` required)
  Add credentials - `createuser -P -s -e *usernamegoeshere*`
  _You can change them at /config/dev.exs_

*INSTALL PROJECT DEPENDENCIES* (inside project's folder)
  Hex - `mix local.hex`
  Brunch, etc. - `npm install`
  Hexes (Elixir gems) - `mix deps.get`
  Javascript tools - `bower install`

 *PROJECT SETUP AND RUN*
  Compile comeonin - `mix deps.compile comeonin`
  _This dependency needs to be compiled separately_
  Create DB - `mix ecto.create`
  Run migrations - `mix ecto.migrate`
  Run project - `iex -S mix phoenix.server`

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
