Puppet::Type.type(:logical_volume).provide(:lvm) do
    desc "Manages LVM logical volumes"
    
    commands :lvcreate => 'lvcreate',
             :lvremove => 'lvremove',
             :lvs      => 'lvs',
             :umount   => 'umount',
             :mount    => 'mount'
end
