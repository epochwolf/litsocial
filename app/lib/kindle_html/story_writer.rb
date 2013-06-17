module KindleHtml
class StoryWriter
  TEMPLATE = Liquid::Template.parse(File.read(File.join(Rails.root, 'app', 'views', 'kindle_html', "story.html.liquid")))

  def initialize(story)
    @story = story
  end

  def to_html
    TEMPLATE.render({
      "story_title" => @story.title,
      "story_author" => @story.user.name,
      "story_contents" => @story.safe_contents
    })
  end
end
end