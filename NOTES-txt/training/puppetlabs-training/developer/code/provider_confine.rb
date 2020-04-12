Puppet::Type.type(:media).provide(:http) do
  confine :has_nfs => 'true'
  # ...
end
