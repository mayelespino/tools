Puppet::Type.type(:rcsrepo).provide(:git) do
  desc "Manages Git"

  commands :git => 'git'

  def exists?
    File.directory?(File.join(resource[:path], '.git'))
  end

  def create
    if resource[:source]
      FileUtils.rm_rf resource[:path] if File.exists?(resource[:path])
      git('clone', resource[:source], resource[:path])
      git_lazy('reset', '--hard', resource[:revision]) if resource[:revision]
    else
      FileUtils.mkdir_p resource[:path] unless File.directory?(resource[:path])
      git('init', resource[:path])
    end
  end

  def destroy
    FileUtils.rm_rf resource[:path] if File.directory?(File.join(resource[:path], '.git'))
  end

  def revision
    git_lazy('rev-parse', 'HEAD').chomp
  end

  def revision=(value)
    # First do a `git fetch origin` to ensure that everything is up-to-date
    # Next, do a `git checkout <revision>`
    git_lazy('fetch', 'origin')
    git_lazy('reset', '--hard', value)
  end

  def git_lazy(*args)
    git('--git-dir', File.join(resource[:path], '.git'), *args)
  end
end

