require 'puppet'
require 'fileutils'

describe 'The git provider for the rcsrepo type' do
  let(:test_dir) { File.join('/tmp', Time.now.to_i.to_s, 'repo') }
  let(:resource) { Puppet::Type::Rcsrepo.new({:path => test_dir}) }
  subject { Puppet::Type.type(:rcsrepo).provider(:git).new(resource) }
  # ...
  after :each do
    FileUtils.rm_rf(File.dirname(test_dir)) if File.exists?(test_dir)
  end
end

