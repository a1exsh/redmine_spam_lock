# redmine_spam_lock -- A Redmine plugin to allow locking unregistered users
# without the need to activate them first.
#
# Copyright (C) 2011  Alex Shuglin <ash@commandprompt.com>
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

require_dependency 'users_helper'

module LockUsersHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :change_status_link, :lock_link
    end
  end
 
  module InstanceMethods
    def change_status_link_with_lock_link(user)
      link = change_status_link_without_lock_link(user)
      if user.registered?
        link + " " + lock_user_link(user)
      else
        link
      end
    end

    def lock_user_link(user)
      # NB: for redmine-0.9.x you might want :action => 'edit' and
      # :method => :post below

      url = {:controller => 'users', :action => 'update', :id => user, :page => params[:page], :status => params[:status], :tab => nil}
      link_to l(:button_lock), url.merge(:user => {:status => User::STATUS_LOCKED}), :method => :put, :class => 'icon icon-lock'
    end
  end
end

UsersHelper.send(:include, LockUsersHelperPatch)
