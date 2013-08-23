require 'grape'
require 'grape-swagger'

module TravisGroveBridge
  class API < Grape::API
    format :json
    desc "Post a webhook from Travis CI to here, and it will send a webhook to Grove.io IRC"
    post :send_to_grove do
      # receive and parse the travis webhook
      payload = JSON.parse(params[:payload])
      commit_sha = payload['commit']
      commit_message = payload['message']
      author_name = payload['author_name']
      repo_name = payload['repository']['name']
      repo_owner = payload['repository']['owner_name']
      status_message = payload['status_message']

      # send to grove
      icon_url = ENV['GROVE_ICON_URL'].blank? ? "https://grove.io/static/img/avatar.png" : ENV['GROVE_ICON_URL']
      message = "Travis CI run #{status_message} for #{repo_name}/#{repo_owner}:: #{commit_message} (#{commit_sha}) by #{author_name}"

      Typhoeus.post(ENV['GROVE_POST_URI'],
        :body => {
          :service => ENV['GROVE_SERVICE_NAME'],
          :message => message,
          :url => "https://grove.io/app",
          :icon_url => icon_url
        }
      )
    end

    get do
      {:status => 'ok'}
    end

    add_swagger_documentation
  end
end

## the following is an example webhook post from Travis CI
# {
#   "payload": {
#     "id": 1,
#     "number": 1,
#     "status": null,
#     "started_at": null,
#     "finished_at": null,
#     "status_message": "Passed",
#     "commit": "62aae5f70ceee39123ef",
#     "branch": "master",
#     "message": "the commit message",
#     "compare_url": "https://github.com/svenfuchs/minimal/compare/master...develop",
#     "committed_at": "2011-11-11T11: 11: 11Z",
#     "committer_name": "Sven Fuchs",
#     "committer_email": "svenfuchs@artweb-design.de",
#     "author_name": "Sven Fuchs",
#     "author_email": "svenfuchs@artweb-design.de",
#     "repository": {
#       "id": 1,
#       "name": "minimal",
#       "owner_name": "svenfuchs",
#       "url": "http://github.com/svenfuchs/minimal"
#      },
#     "matrix": [
#       {
#         "id": 2,
#         "repository_id": 1,
#         "number": "1.1",
#         "state": "created",
#         "started_at": null,
#         "finished_at": null,
#         "config": {
#           "notifications": {
#             "webhooks": ["http://evome.fr/notifications", "http://example.com/"]
#           }
#         },
#         "status": null,
#         "log": "",
#         "result": null,
#         "parent_id": 1,
#         "commit": "62aae5f70ceee39123ef",
#         "branch": "master",
#         "message": "the commit message",
#         "committed_at": "2011-11-11T11: 11: 11Z",
#         "committer_name": "Sven Fuchs",
#         "committer_email": "svenfuchs@artweb-design.de",
#         "author_name": "Sven Fuchs",
#         "author_email": "svenfuchs@artweb-design.de",
#         "compare_url": "https://github.com/svenfuchs/minimal/compare/master...develop"
#       }
#     ]
#   }
# }