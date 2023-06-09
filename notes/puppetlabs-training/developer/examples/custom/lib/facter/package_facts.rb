found = false
IO.popen('yum list installed').readlines.each do |line|
  if !found
    found = true if line.include?('Installed Packages')
    next
  end
  name, version, info = line.split(/\s+/, 3)
  # Remove non-alphanumeric characters, arch ending
  clean_name = name.sub(/\..*?$/, '').gsub(/\W/, '')
  Facter.add("yum_#{clean_name}_version") do
    setcode { version }
  end
end
