a = 'cat'

b = 5

c = nil

begin
  a + b
  c + a
rescue TypeError
  puts "that's not right!"
rescue NoMethodError
  puts "did c get reached?"
end
