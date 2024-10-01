hostclass :ssh do
  package "ssh", 
    :name => 'openssh',
    :ensure => :present
  file "/etc/ssh/sshd_config",
    :source => "puppet:///ssh/sshd_config", 
    :require => "Package[ssh]"
  service :sshd, 
    :ensure => :running, 
    :require => "File[/etc/ssh/sshd_config]"
end

