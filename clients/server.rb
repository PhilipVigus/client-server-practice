require 'socket'

server = TCPServer.new(2345)
socket = server.accept

name = ""

while name != 'quit' do
  socket.puts "Hello client, what's your name?"
  name = socket.gets.chomp
  socket.puts "What a strange name #{name} is!"
  socket.puts "Try again or quit"
end
socket.close