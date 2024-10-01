module Puppet::Parser::Functions
  newfunction(:lookupinclude,
              :doc => "Looks up and includes classes defined in a field") do |args|
    args.unshift("/etc/puppet/lookupinclude.yml")
    classes = function_extractvalue(args)
    function_include(classes)
  end
end
