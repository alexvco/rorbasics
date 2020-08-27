class AlbumsController < ApplicationController

  def index
    req = Net::HTTP::Get.new(uri.request_uri)
    req['Access-Token'] = 'my_access_token_value'
    req["User-Agent"] = "My Ruby Script"
    req["Accept"] = "*/*"
    req.basic_auth("username", "password")

    response = api_client.request(req)
    if response.code == '200'
      @albums = JSON.parse(response.body) # this is an array/hash and not an object
    else
      puts response.code # 404
      puts response.body # {}
      puts response.message # Not Found
    end
  end

  def new
  end

  def create
    req = Net::HTTP::Post.new(uri.request_uri)
    req['Content-Type'] = 'application/json'
    req['Access-Token'] = 'my_access_token_value'
    req.basic_auth("username", "password")
    req.body = album_params.to_json

    response = api_client.request(req)

    if response.code == '201'
      puts JSON.parse(response.body)
      redirect_to albums_path, notice: 'Album was created'
    else
      puts response.code # 404
      puts response.body # {}
      puts response.message # Not Found
    end
  end

  private

  # cheatsheet net/http
  # https://docs.ruby-lang.org/en/2.0.0/Net/HTTP.html
  # https://yukimotopress.github.io/http

  def album_params
    params.require(:nor_album).permit(:id, :title)
  end

  def uri
    @uri ||= URI.parse('https://jsonplaceholder.typicode.com/albums?foo=bar')
  end

  def api_client
    @api_client ||= begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 600
      http.use_ssl = true
      http
    rescue => e
      puts "api_client error: #{e.message}"
    end
  end
end
