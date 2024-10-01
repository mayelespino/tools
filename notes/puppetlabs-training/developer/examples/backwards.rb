ARGV.reverse.each do |filename|
  File.readlines(filename).reverse.each do |line|
    puts line
  end
end
