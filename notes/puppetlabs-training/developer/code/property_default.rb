Puppet::Type.newtype(:media) do
  # ...
  newproperty(:mode) do
    desc "The mode of the file"
    newvalues(/^\d+$/)
    defaultto '0755'
    munge do |value|
      # Ensure octal
      unless value[0, 1] == '0'
        value = "0#{value}"
      end
      Integer(value)
    end
  end
end
