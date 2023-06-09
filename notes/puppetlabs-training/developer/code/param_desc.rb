Puppet::Type.newtype(:media) do
  # ...
  newparam(:path) do
    desc "The location to store the media file"
    # ...
  end
end
