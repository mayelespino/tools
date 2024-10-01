Puppet::Type.type(:media).provide(:http) do
  # ...

  def mode=(value)
    FileUtils.chmod(value, resource[:path])
  end

end
