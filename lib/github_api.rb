require "graphql/client"
require "graphql/client/http"

module GithubAPI

  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      token = context[:access_token] || ENV["GITHUB_ACCESS_TOKEN"]
      { "Authorization" => "Bearer #{token}"}
    end
  end

  # Expects the schema to have been prefetched with bin/rake graphql:schema:dump
  Schema = GraphQL::Client.load_schema("config/schemas/github_api.json")
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
