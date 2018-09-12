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
        env['warden'].logout
        ['200', {'Content-Type' => 'text/html'}, ["GoodBye!"]]
      when '/protected'
        env['warden'].authenticate!
        ['200', {'Content-Type' => 'text/html'}, ['This is a protected page!']]
      end
    end
end