define :mkdir_p do
  name = @name
  until name == '/'
    file name, :ensure => 'directory'
    name = File.dirname(name)
  end
end
node 'default' do
  mkdir_p '/tmp/foo/bar/baz'
end
