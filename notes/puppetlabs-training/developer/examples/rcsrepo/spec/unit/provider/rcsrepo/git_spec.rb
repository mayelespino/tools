require 'puppet'
require 'puppet/type/rcsrepo'
require 'mocha'
RSpec.configure do |config|
  config.mock_with :mocha
end
require 'fileutils'
describe 'The git provider for the rcsrepo type' do
  let(:test_dir) { File.join('/tmp', Time.now.to_i.to_s, 'repo') }
  let(:resource) { Puppet::Type::Rcsrepo.new({:path => test_dir}) }
  subject { Puppet::Type.type(:rcsrepo).provider(:git).new(resource) }

  it 'should ensure that a git directory does not exist initially' do
    subject.exists?.should == false
  end

  it 'should create a directory for a new git init' do
    FileUtils.expects(:mkdir_p)
    FileUtils.expects(:rm_rf).never
    subject.expects(:git).with('init', test_dir)
    subject.create
  end
  it 'should not create a directory for a git clone' do
    FileUtils.expects(:mkdir_p).never
    FileUtils.expects(:rm_rf).never
    subject.expects(:git).with('clone', 'git://github.com/puppetlabs/puppetlabs-stdlib.git', test_dir)
    subject.resource[:source] = 'git://github.com/puppetlabs/puppetlabs-stdlib.git'
    subject.create
  end
  it 'should ensure that a git directory exists?' do
    subject.create
    subject.exists?.should == true
  end
  it 'should ensure that destroyed repos are removed' do
    # Why am I NOT stubbing out FileUtils.rm_rf?
    # Answer: I WANT to check to see if it removes a repo
    subject.resource[:source] = 'git://github.com/puppetlabs/puppetlabs-stdlib.git'
    subject.create
    subject.exists?.should == true
    subject.destroy
    subject.exists?.should == false
  end
  it 'should check out the desired revision' do
    subject.resource[:source] = 'git://github.com/puppetlabs/puppetlabs-stdlib.git'
    subject.create
    subject.revision = '666225c988ed14e70137711d4b87477ec542c117'
    subject.revision.should == '666225c988ed14e70137711d4b87477ec542c117'
  end
  after :each do
    FileUtils.rm_rf(File.dirname(test_dir)) if File.exists?(test_dir)
  end
end

