require 'socket'

server = TCPServer.new(2345)

while true do
  Thread.start(server.accept) do |s|
    they_said = ""
    while they_said !="quit" do
      s.puts "What do you say?"
      they_said = s.gets.chomp
      if they_said == 'quit'
        s.close
      else
        s.puts "You said: #{they_said}."
      end
    end
  end
end
