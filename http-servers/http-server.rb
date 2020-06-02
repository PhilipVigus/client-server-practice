require 'socket'

def run_server
  server = TCPServer.new(2345)

  loop do
    # Accepts an incoming connection and returns a TCPSocket object
    socket = server.accept

    # each request is deilineated by a space either side
    # this reads and returns a request
    request = get_lines_until_blank_line(socket)

    # print the request
    puts "=== GOT REQUEST ==="
    puts request
    puts "=== END REQUEST ==="

    # response is the body that gets sent to the client
    if request.start_with? "GET / HTTP/1.1"
      response = "Hello World!\n"
    elsif request.start_with? "GET /secret_page HTTP/1.1"
      response = "1. The gold is buried at harald creek\n"
      response += "2. OK I only have one secret"
    else
      response = "Nothing found :("
    end

    # adds the response header and concatenates it to the body
    http_response = build_http_response(response)

    # sends the response to the client
    socket.print http_response

    # echo the response to the server log
    puts "=== SENT RESPONSE ==="
    puts http_response
    puts "=== END RESPONSE ==="
    puts "\n"

    # close the client connection
    socket.close
  end
end

def get_lines_until_blank_line(socket)
  message = ""
  loop do
    # gets a line from the socket
    line = socket.gets

    # trims the line and adds it if there's some content
    if line.chomp == ""
      break
    else
      message += line
    end
  end
  message
end

def build_http_response(response)
  "HTTP/1.1 200 OK\r\n" +
    "Content-Type: text/plain\r\n" +
    "Content-Length: #{response.bytesize}\r\n" +
    "Connection: close\r\n" +
    "\r\n" +
    response
end

run_server