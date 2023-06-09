Puppet::Type.newtype(:thing) do
  newparam(:name) do
    desc "The name of the thing"
    isnamevar
  end
  newparam(:owner) do
    desc "The owner of the thing"
  end
  # Autorequire a user with the same name as the owner
  autorequire :thing do
    [
     [:user, self[:owner]]
    ]
  end
end
