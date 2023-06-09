Facter.add('has_yum') do
  setcode { File.exist?('/usr/bin/yum') ? 'true' : 'false' }
end

Facter.add('yum_version') do
  confine :has_yum => 'true'
  setcode do
    %x{yum --version}.split("\n").first
  end
end
