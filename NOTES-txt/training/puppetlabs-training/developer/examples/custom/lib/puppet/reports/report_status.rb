require 'puppet'

Puppet::Reports.register_report(:getstatus) do
  def process
    File.open('/var/lib/puppet/reports/report.txt', 'a') do |f|
      f.puts "#{host}-#{time}"
      resource_statuses.each do |resource_id, status|
        unless status.events.empty?
          f.puts "  #{resource_id}"
          status.events.each do |event|
            f.puts "    #{event.property}:#{event.previous_value}:#{event.desired_value}"
          end
        end
      end
    end
  end
end
