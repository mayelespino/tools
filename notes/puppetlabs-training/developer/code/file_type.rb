file "/etc/ssh/sshd_config",
  :source => "puppet:///modules/ssh/sshd_config",
  :require => "Package[ssh]"
