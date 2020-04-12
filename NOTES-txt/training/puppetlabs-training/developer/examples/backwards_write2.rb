outfile = ARGV.pop
File.open(outfile, 'a') do |fh|
  ARGV.reverse.each do |filename|
    File.readlines(filename).reverse.each do |line|
      fh.puts line
    end
  end
end
