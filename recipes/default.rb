#
# Cookbook Name:: jenkins-server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'ruby-shadow'

user 'jenkins' do
	group 'root'
end

file '/etc/shadow' do
	owner 'root'
	group 'root'
	mode '040'
end

user 'freefood89' do
	password '$1$mmsalty$ElVBy0gBbBoO9eidKYm9z.'
end

include_recipe 'jenkins::master'

jenkins_plugin 'github-oauth' do
	install_deps true
	notifies :restart, 'service[jenkins]', :immediately
end

jenkins_plugin 'docker-plugin' do
	notifies :restart, 'service[jenkins]', :immediately
end

template '/var/lib/jenkins/config.xml' do
	source 'config.xml.erb'
end

jenkins_command 'reload-configuration'