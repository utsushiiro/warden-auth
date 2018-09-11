require 'rack'
require './Application'
require './User'
require 'warden'

use Rack::Session::Cookie, secret: ENV['COOKIE_SECRET_KEY'] || 'hoge'

use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = lambda {|env| ['401', {'Content-Type' => 'text/html'}, ['failed']]}
end

Warden::Manager.serialize_into_session {|user| user.id}

Warden::Manager.serialize_from_session {|id| User.find(id)}

Warden::Strategies.add(:password) do
  def valid?
    params['id'] && params['password']
  end

  def authenticate!
    user = User.authenticate(params['id'], params['password'])
    user.nil? ? fail!("Authentication failed") : success!(user)
  end
end

run Application.new