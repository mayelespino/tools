require 'puppet'
require 'puppet/type/rcsrepo'
describe Puppet::Type.type(:rcsrepo) do
  subject { Puppet::Type.type(:rcsrepo).new(:path => '/foo') }

  it 'should accept a valid revision' do
    subject[:revision] = 'v1'
    subject[:revision].should == 'v1'
  end
  it 'should not accept revisions that have whitespec characters' do
    expect { subject[:revision] = ' '}.should raise_error(Puppet::Error, /Invalid value/)
  end
  it 'should require that path be absolute' do
    expect {Puppet::Type.type(:rcsrepo).new(:path => 'foo') }.should raise_error(Puppet::Error, /Path must be absolute/)
  end
  it 'should fail for invalid URIs' do
    expect {subject[:source] = ' '}.should raise_error(Puppet::Error, /bad URI/)
  end
  it 'should accept valid URIs' do
    subject[:source] = 'http://foo'
    subject[:source].should == 'http://foo'
  end
end
