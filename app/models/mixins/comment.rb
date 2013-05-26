module Mixins
module Lockable
  def self.included(mod)
    mod.has_many :comments
  end
  
end
end