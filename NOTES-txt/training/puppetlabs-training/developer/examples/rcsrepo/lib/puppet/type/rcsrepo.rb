require 'pathname'
require 'uri'
Puppet::Type.newtype(:rcsrepo) do
  desc "A local version control repository"

  ensurable

  newproperty(:revision) do
    desc "The revision of the repository"
    newvalues(/^\S+$/)
  end

  newparam(:path, :namevar => true) do
    desc "Absolute path to repository"
    validate do |value|
      path = Pathname.new(value)
      unless path.absolute?
        raise ArgumentError, "Path must be absolute: #{path}"
      end
    end
  end

  newparam(:source) do
    desc "The source URL for the repository"
    validate do |value|
      URI.parse(value)
    end
  end
end
