Facter.add 'something_using_dscl' do
  confine :kernel => 'darwin'
  # ...
end
