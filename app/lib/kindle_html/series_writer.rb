module KindleHtml
class SeriesWriter
  TEMPLATE = Liquid::Template.parse(File.read(File.join(Rails.root, 'app', 'views', 'kindle_html', "series.html.liquid")))

  def initialize(series)
    @series = series
    @stories = series.stories.visible
  end

  def to_html
    TEMPLATE.render({
      "series_title" => @series.title,
      "series_author" => @series.user.name,
      "stories" => @stories.map{|s| {"id" => s.id, "title" => s.title, "contents" => s.safe_contents} },
    })
  end
end
end