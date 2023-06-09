Puppet::Type.newtype(:media) do
  # ...  
  newparam(:source) do
    desc "The source URL for the file"
    validate do |value|
      unless value =~ /^(https?|ftp):\/\//
        raise ArgumentError, "Source is not a HTTP(S) or FTP URL: #{value}"
      end
    end
    munge do |value|
      value = URI.parse(value)
      case value.scheme
      when /^http/
        resource[:provider] = :http
      else
        resource[:provider] = value.scheme.to_sym
      end
      value
    end
  end
end
