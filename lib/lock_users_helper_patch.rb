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
      url = {:controller => 'users', :action => 'update', :id => user, :page => params[:page], :status => params[:status], :tab => nil}
      link_to l(:button_lock), url.merge(:user => {:status => User::STATUS_LOCKED}), :method => :put, :class => 'icon icon-lock'
    end
  end
end

UsersHelper.send(:include, LockUsersHelperPatch)
