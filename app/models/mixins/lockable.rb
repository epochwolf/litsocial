module Mixins
module Lockable

  def locked?
    locked_at ? true : false
  end

  def locked
    locked?
  end

  def locked=(bool)
    if bool.to_i == 0
      self.locked_at = nil
    elsif !locked?
      self.locked_at = DateTime.now
    end
  end
  
end
end