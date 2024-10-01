Facter.add('open_ports') do
  setcode do
    IO.popen('netstat -f inet -n').readlines.inject([]) do |ports, line|
      proto, recv, send, local, foreign, state = line.split(/\s+/)
      if proto == 'tcp4'
        ports << local.split('.').last
      else
        ports
      end
    end
  end
end
