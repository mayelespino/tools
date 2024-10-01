node 'default' do
  file '/tmp/one',
    :content => Facter[:operatingsystem].value
end
