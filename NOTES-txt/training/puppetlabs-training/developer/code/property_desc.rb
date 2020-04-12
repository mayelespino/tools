Puppet::Type.newtype(:media) do
  # ...
  newproperty(:mode) do
    desc "The mode of the file"
  end
end
