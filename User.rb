class User
    attr_accessor :id, :password
  
    USER_MAPPING = {
      sample_user: 'password'
    }
  
    def initialize(id, password)
      self.id = id
      self.passworkd = password
    end
  
    def self.find(id)
      User.new(id, USER_MAPPING[id.to_sym])
    end
  end