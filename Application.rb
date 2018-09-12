class Application
    def call(env)
      request = Rack::Request.new(env)
      case request.path_info
      when '/'
        ['200', {'Content-Type' => 'text/html'}, ["Hello Rack!"]]
      when '/login'
        env['warden'].authenticate!
        ['200', {'Content-Type' => 'text/html'}, ["Hello #{env['warden'].user.id}!"]]
      when '/logout'
        id = env['warden'].user.id
        env['warden'].logout
        ['200', {'Content-Type' => 'text/html'}, ["GoodBye #{id}!"]]
      end
    end
end