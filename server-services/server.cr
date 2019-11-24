require "http/server"
require "json"

server = HTTP::Server.new do |context|
  request = context.request
  response = context.response

  access_control = "*"
  response.content_type = "application/json; charset=utf-8"
  response.headers["Access-Control-Allow-Origin"] = access_control

  # Routing
  case request.path
  when "/"
    response.content_type = "text/plain"
    response.print "Hi!"
  when "/substrings"
    sentence = request.query_params["sentence"]?

    if sentence.nil?
      response.respond_with_status 400 # => 400 Bad Request
    else
      substrings = sentence.split(' ', remove_empty: true)
      body = JSON.build() do |json|
        json.array do
          substrings.each {|substring| json.string(substring)}
        end
      end
      response.print body
    end
  when "/firstletter"
    word = request.query_params["word"]?

    if word.nil?
      response.respond_with_status 400 # => 400 Bad Request
    else
      body = JSON.build() do |json|
        json.string word[0]
      end
      response.print body
    end
  when "/touppercase"
    word = request.query_params["word"]?

    if word.nil?
      response.respond_with_status 400 # => 400 Bad Request
    else
      body = JSON.build() do |json|
        json.string word.upcase
      end
      response.print body
    end
  when "/vowels"
    word = request.query_params["word"]?

    if word.nil?
      response.respond_with_status 400 # => 400 Bad Request
    else
      vowels = ['a','e','i','o','u']

      body = JSON.build() do |json|
        json.array do
          word.downcase.each_char{|c| json.string(c) if vowels.includes?(c)}
        end
      end

      response.print body
    end
  else
    response.respond_with_status 404 # => 404 Not Found
  end
end

address = server.bind_tcp 8082
puts "Listening on http://#{address}"
server.listen
