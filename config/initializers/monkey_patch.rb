# Monkey patches to ruby go here

class String 
  def self.random
    UUID.new.generate
  end
end