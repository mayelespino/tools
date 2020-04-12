Puppet::Type.newtype(:media) do
  # ...
  newparam(:path, :namevar => true) do
    desc "The location to store the media file"
    # ...
  end
end
