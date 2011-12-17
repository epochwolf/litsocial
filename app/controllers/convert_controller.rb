require 'fileutils'

class ConvertController < ApplicationController
  
  def word_doc
      if params[:word_doc].respond_to? :tempfile
        file = File.join(Rails.root, "tmp", params[:word_doc].original_filename)
        begin
          FileUtils.cp(params[:word_doc].tempfile.path, file)
          @text = WordConverter.new(file).to_html
        ensure
          FileUtils.rm(file)
        end
        file = params[:word_doc].tempfile
      else
        @text = params.inspect
      end
      @text = @text.html_safe
      render :layout => nil
    end
    
end
