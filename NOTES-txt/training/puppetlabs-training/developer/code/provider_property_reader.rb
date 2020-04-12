Puppet::Type.type(:media).provide(:http) do
  # ...

  def mode
    octal = File.stat.mode(resource[:path]).to_s(8)
    # For now, only care about the last 4 digits
    Integer(octal[-4..-1])
  end

end
