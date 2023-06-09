Puppet::Type.newtype(:volume_group) do
  newparam(:physical_volumes, :array_matching => :all) do
    # ...
  end
end
