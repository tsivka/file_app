class FolderController < ApplicationController

  def index
    @folders=directory_hash('/home/roman/Downloads', name=nil);
  end


  # def show
  #   'cdsfdfd'
  # end


  def content
    @folders=directory_hash(params[:paths], name=nil);
   render :partial => "list"

  end

  private

  def directory_hash(path, name=nil)
    data = {:data => (name || path)}
    data[:children] = children = []
    Dir.foreach(path) do |entry|
      next if (entry == '..' || entry == '.')
      full_path = File.join(path, entry)
      if File.directory?(full_path)
        children << directory_hash(full_path, entry)
      else
        children << entry
      end
    end
    return data
  end
end
