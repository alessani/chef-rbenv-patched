#
# Cookbook Name:: rubymachine
# Recipe:: default
#
# Copyright 2012, Extendi
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rbenv"
include_recipe "rbenv::ruby_build"

package "autoconf"
package "libxslt1-dev" # Needed for nokogiri

node["rubymachine"]["rubies"].each do |ruby_ver|
  rbenv_ruby ruby_ver

  rbenv_gem "bundler" do
    ruby_version ruby_ver
  end
end

node["rubymachine"]["patched_rubies"].each do |ruby_ver|
  ruby_installed = FileTest.directory?("/opt/rbenv/versions/#{ruby_ver}-perf")
  template "/tmp/installer.sh" do
    source "rbenv_installer.sh.erb"
    mode 0755
    owner "root"
    group "root"
    action :create
    variables(
      :ruby => ruby_ver
    )
    not_if {ruby_installed}
  end

  execute "install ruby #{ruby_ver} patched" do
    command "sudo -i /tmp/installer.sh"
    action :run
    not_if {ruby_installed}
  end

  rbenv_gem "bundler" do
    ruby_version "#{ruby_ver}-perf"
    gem_binary "/opt/rbenv/versions/#{ruby_ver}-perf/bin/gem"
  end
end

rbenv_global node["rubymachine"]["default"]

