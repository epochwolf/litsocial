module Mixins
module Taggable

  def self.included(mod)
    mod.scope :tagged, ->(tags){ where.contains(:tags => tags) }
  end

  def tag_list
    tags.join(", ")
  end

  def tag_list=(str)
    self.tags = str.downcase.split(/\s*,\s*/).reject(&:blank?).map(&:parameterize)
  end
  
end
end