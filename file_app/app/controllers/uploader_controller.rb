class UploaderController < ApplicationController
  def new

  end
  def create
    name = params[:uploader][:file].original_filename
    path = Rails.root.join('public','files', name)
    File.open(path, "wb") { |f| f.write(params[:uploader][:file].read) }
    flash[:notice] = "File uploaded"
    redirect_to folder_index_path
  end
end
