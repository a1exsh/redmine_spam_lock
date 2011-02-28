require 'redmine'

require 'lock_users_helper_patch'

Redmine::Plugin.register :redmine_spam_lock do
  name 'Redmine Spam Lock plugin'
  author 'Alex Shulgin <ash@commandprompt.com>'
  description 'A plugin to allow lock unregistered users w/o the need to activate them first'
  version '0.0.1'
  #url 'http://example.com/path/to/plugin'
  #author_url 'http://example.com/about'
end
