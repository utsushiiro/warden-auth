class Application
    def call(env)
      env['warden'].authenticate!
      ['200', {'Content-Type' => 'text/html'}, ["Hello #{env['warden'].user.id}!"]]
    end
end