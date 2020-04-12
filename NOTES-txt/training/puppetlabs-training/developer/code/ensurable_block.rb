Puppet::Type.newtype(:group) do
  ensurable do
    desc "Create or remove the group."
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.delete
    end
    # ...
  end
end


