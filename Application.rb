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
        if env['warden'].authenticate?
          env['warden'].logout
          ['200', {'Content-Type' => 'text/html'}, ["GoodBye!"]]
        else
          ['401', {'Content-Type' => 'text/html'}, ['Unauthorized']]
        end
      when '/protected'
        if env['warden'].authenticate?
          ['200', {'Content-Type' => 'text/html'}, ['This is a protected page!']]
        else
          ['401', {'Content-Type' => 'text/html'}, ['Unauthorized']]
        end
      end
    end
end