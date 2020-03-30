require 'socket'

socket = TCPSocket.new('localhost', 2345)
puts socket.gets
puts "Wow what a rude server... I'm going to say Bob"
socket.puts "Bob"
puts socket.gets
socket.close