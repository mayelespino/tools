require 'fileutils'
require 'curl'

Puppet::Type.type(:media).provide(:http) do
  confine :has_nfs => 'true'

  def create
    Curl::Easy.download(resource[:source], resource[:path])
  end
  def exists?
    File.file?(resource[:path])
  end
  def destroy
    FileUtils.rm_rf(resource[:path])
  end
  # ...
end
