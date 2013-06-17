class KindleMailer < ActionMailer::Base
  default from: "mailferret@litsocial.com"

  def series_email(email, series)
    @series = series
    attachments["#{clean_title @series.title}.html"] = KindleHtml::SeriesWriter.new(@series).to_html
    mail(:to => email, :subject => "Series: #{clean_title @series.title}") do |format|
      format.text { render :text => 'File Attached' }
    end
  end

  def story_email(email, story)
    @story = story
    attachments["#{clean_title @story.title}.html"] = KindleHtml::StoryWriter.new(@story).to_html
    mail(:to => email, :subject => "Story: #{clean_title @story.title}") do |format|
      format.text { render :text => 'File Attached' }
    end
  end

  def clean_title(string)
    string.gsub /\W+/, " "
  end
end
