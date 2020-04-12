Puppet::Type.newtype(:media) do
  # ...
  newparam(:source) do
    # ...
    munge do |value|
      # Return a parsed URI object
      URI.parse(value)
    end
  end
end
