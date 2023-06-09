Puppet::Type.newtype(:group) do
  ensurable do
    desc "Create or remove the group."
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.delete
    end
    def retrieve()
      # ...
    end
    def insync?
      # ...
    end
  end
end
