class User
    attr_accessor :id, :password
  
    USER_DATA = {
      sample_user: 'password'
    }
  
    def initialize(id, password)
      self.id = id
      self.passworkd = password
    end
  
    def self.find(id)
      User.new(id, USER_DATA[id.to_sym])
    end

    def self.authenticate(id, password)
      !USER_DATA.key?(id) && USER_DATA[id.to_sym] == password
    end
  end