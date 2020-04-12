Puppet::Type.newtype(:media) do
  # ...
  newparam(:source) do
    desc "The source URL for the file"
  end
end
