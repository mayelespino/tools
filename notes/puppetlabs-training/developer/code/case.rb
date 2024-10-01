name = "Joey"

case name
when "John"
  puts "Go away, John."
when "Joseph", /^joey?/i
  puts "Hello, Joe!"
else
  puts "Umm, hi."
end
