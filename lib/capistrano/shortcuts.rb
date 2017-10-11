require "capistrano/shortcuts/version"

[:apache, :config, :database, :memcache, :web].each do |token|
  load File.expand_path("../shortcuts/tasks/deploy_#{token}.rake", __FILE__)
end


# module Capistrano
#   module Shortcuts
#     # Your code goes here...
#   end
# end




