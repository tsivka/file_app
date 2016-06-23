class FolderController < ApplicationController

  def index
    @folders=directory_hash("#{Rails.root}/public", name=nil);
  end


  def show_file
    @myfile = File.read(params[:paths])

    render :text => @myfile
  end

  def create_file
    path = params[:paths]
    content = params[:content]

    @myfile=File.open(path, "w+") do |f|
      f.write(content)
    end
    render :text => @myfile
  end

  def content
    @folders=directory_hash(params[:paths], name=nil);
   render :partial => "list"

  end

  def download_file
    file_path= params[:download][:filepath]
    send_file Rails.root.join(file_path)
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
