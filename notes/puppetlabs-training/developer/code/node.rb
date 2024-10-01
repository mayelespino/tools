node 'default' do
  file '/etc/motd',
    :content => template('/etc/puppet/templates/motd.erb')
end
