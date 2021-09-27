class DocumentsController < ApplicationController
  before_action :attachable

  def index
    @documents = @attachable.documents
    respond_to do |format|
      format.js
    end
  end

  def new
    @document = Document.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @document = Document.new
    @document.attachable = @attachable
    @document.file = params[:document][:file]

    respond_to do |format|
      if @document.save
        format.js { flash.now[:notice] = t('shared.success.add', resource_label: t('documents.label')) }
      else
        format.js { flash.now[:error] = @document.errors.full_messages }
      end
    end
  end

  def destroy
    @document = Document.find_by(id: params[:id])
    respond_to do |format|
      if @document.destroy
        format.js { flash.now[:notice] = t('shared.success.delete', resource_label: t('documents.label')) }
      else
        format.js { flash.now[:error] = @document.errors.full_messages }
      end
    end
  end

  def download
    @document = Document.find_by(id: params[:id])
    send_file(@document.file.path, filename: @document.file_file_name, type: @document.file.content_type)
  end

  private

  def document_params
    params.require(:document).permit(:file)
  end

  def attachable
    @attachable = params[:sprint_id].nil? ? Issue.find_by(sequence_num: params[:issue_id]) : Sprint.find_by(sequence_num: params[:sprint_id])
  end
end
