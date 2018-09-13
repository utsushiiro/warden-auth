class Application
    def call(env)
      request = Rack::Request.new(env)
      case request.path_info
      when '/'
        ['200', {'Content-Type' => 'text/html'}, ["Hello Rack!\n"]]
      when '/login'
        env['warden'].authenticate!
        ['200', {'Content-Type' => 'text/html'}, ["Hello #{env['warden'].user.id}!\n"]]
      when '/logout'
        if env['warden'].authenticate?
          env['warden'].logout
          ['200', {'Content-Type' => 'text/html'}, ["GoodBye!\n"]]
        else
          ['401', {'Content-Type' => 'text/html'}, ["Unauthorized\n"]]
        end
      when '/protected'
        if env['warden'].authenticate?
          ['200', {'Content-Type' => 'text/html'}, ["This is a protected page!\n"]]
        else
          ['401', {'Content-Type' => 'text/html'}, ["Unauthorized\n"]]
        end
      end
    end
end