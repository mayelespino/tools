require 'yaml'

module Puppet::Parser::Functions
  newfunction(:extractvalue,
              :type => :rvalue,
              :doc  => "Extract a value from a YAML file.") do |args|
    path, field, format = args
    format ||= 'yaml'
    if File.file?(path)
      parser.watch_file(path)
      raw_data = File.read(path)
      case format
      when 'yaml'
        data = YAML.load(raw_data)
      when 'json'
        data = PSON.parse(raw_data)
      else
        raise Puppet::Error, "Unknown format: #{format}"
      end
      data[field] # Allow nil
    else
      raise PuppetError, "Missing file for extractvalue: #{file}"
    end
  end
end
  
