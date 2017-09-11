namespace :graphql do
  require_relative "../../lib/github_api"

  desc "Serialize the latest Directory GraphQL API schema"
  namespace :schema do
    task :dump do
      schema_path = "config/schemas/github_api.json"
      FileUtils.rm(schema_path, force: true)
      GraphQL::Client.dump_schema(GithubAPI::HTTP, schema_path)
    end
  end
end
