class Application
    def call(env)
      env['warden'].authenticate!
      ['200', {'Content-Type' => 'text/html'}, ['Hello Rack!']]
    end
end