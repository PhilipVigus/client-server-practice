require 'socket'

socket = TCPSocket.new('localhost', 2345)
name = ""
while name !='quit' do
  puts socket.gets
  puts "Wow what a rude server... Lets think about a name"
  name = gets.chomp
  socket.puts name
  puts socket.gets
end
socket.close
