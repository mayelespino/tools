Facter.add('yum_version') do
  confine :operatingsystem => %w(Fedora RedHat CentOS)
  set_code do
    %x{yum --version}.split("\n").first
  end
end
