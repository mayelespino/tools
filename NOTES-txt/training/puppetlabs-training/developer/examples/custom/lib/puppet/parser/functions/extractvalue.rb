require 'yaml'

Puppet::Parser::Functions.newfunction(
    :extractvalue,
    :type => :rvalue,
    :doc  => "Extract a value from a YAML file.") do |args|
  raise Puppet::ArgumentError unless args.length == 2
  raise Puppet::ArgumentError unless args[0] =~ /^\//
  path, field = args
  if File.file?(path)
    data = YAML.load_file(path)
    data[field] # Allow nil
  else
    raise PuppetError, "Missing file for extractvalue: #{file}"
  end
end
