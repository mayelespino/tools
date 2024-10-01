require 'puppet'
Puppet::Reports.register_report(:myreport) do
  desc "document the report"
  def process
    # report logic goes here
  end
end
