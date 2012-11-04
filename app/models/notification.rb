class Notification < ActiveRecord::Base
  attr_accessible :data, :notifiable, :read, :template, :user
  serialize :data
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  scope :sorted, order(:id.desc)

  NOTIFY_ON = %w[
    Comment
    ForumPost
    Message
    Series
    Story
  ]

  TEMPLATES_AVAILABLE = [
    "comment_create",
    # "comment_update",
    # "forum_post_create",
    # "forum_post_update",
    "message_create",
    # "series_create",
    "series_update",
    "story_create",
    # "story_update",
  ]

  template_folder = File.join(Rails.root, 'app', 'views', 'notification_templates')

  TEMPLATES = Hash[
    *TEMPLATES_AVAILABLE.map do |v|
          [
            v,
            Liquid::Template.parse(File.read(File.join(template_folder, "#{v}.html.liquid")))
          ]  
    end.flatten
  ]

  def to_html
    liquid_template.render(data).html_safe
  end

  protected

  def liquid_template
    TEMPLATES[template]
  end
end
