Facter.add('open_ports') do
  setcode do
    IO.popen('netstat -nlt').readlines.collect do |line|
      proto, recv, send, local, foreign, state = line.split(/\s+/)
      if local =~ /\S+:(\d+)$/
        $1
      end
    end.compact.join(',')
  end
end
