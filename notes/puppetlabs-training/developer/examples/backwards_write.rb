output = ARGV.pop
File.open(output, 'w') do |f|
  ARGV.reverse.each do |filename|
    File.readlines(filename).reverse.each do |line|
      f.puts line
    end
  end
end
