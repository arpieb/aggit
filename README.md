# Aggit

**Aggit** is an Elixir + Phoenix AggPubSub service application that can be configured to pull content from multiple feeds (Agg-regation) and tag content according to defined filter rules, and then make it available for consumption by feed readers, REST clients, and websocket clients (PubSub).

## Architectural Goals

* Provide a pluggable authentication system that can be easily extended.
* Provide a pluggable filter system for inbound content.
* Provide a pluggable tagging system for inbound content.
* Provide a pluggable service system for adding new Agg source types.
* Provide a pluggable service system that allows for adding new PubSub sources.
* Provide a pluggable admin interface that can be customized/extended for enhanced admin needs.

## Running

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
