#!/usr/bin/env ruby
# vim: set sw=2 sts=2 et tw=80 :

def filter_password(text, password)
  text.gsub(password, 'x' * password.size)
end

puts filter_password("Myspace's #1 most-used password is password0", 'password0')

# Also:
class String
  def filter_password(password)
    self.gsub(password, 'x' * password.size)
  end
end

puts "Myspace's #1 most-used password is password0".filter_password('password0')
