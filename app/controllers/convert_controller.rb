require 'fileutils'

class ConvertController < ApplicationController
  
  def word_doc
      if params[:word_doc].respond_to? :tempfile
        file = File.join(Rails.root, "tmp", params[:word_doc].original_filename)
        begin
          FileUtils.cp(params[:word_doc].tempfile.path, file)
          @text = WordConverter.html_from_file(file)
        ensure
          FileUtils.rm(file)
        end
      else
        @text = params.inspect
      end
      @text = @text.html_safe
      render :layout => nil
    end
    
end
