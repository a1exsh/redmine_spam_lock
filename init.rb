require 'redmine'

require 'lock_users_helper_patch'

Redmine::Plugin.register :redmine_spam_lock do
  name 'Redmine Spam Lock plugin'
  author 'Alex Shulgin <ash@commandprompt.com>'
  description 'A plugin to allow locking unregistered users without the need to activate them first.'
  version '0.0.1'
  url 'http://github.com/a1exsh/redmine_spam_lock'
  #author_url 'http://example.com/about'

  requires_redmine :version_or_higher => '1.1.0'
end
