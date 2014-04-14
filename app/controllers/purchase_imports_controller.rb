class PurchaseImportsController < ApplicationController

  def create
    file = params[:file]
    if file
      process_file
      url_after_save
    else
      redirect_to root_url, alert: "File incorrectly formated or no file selected."
    end
  end

  private
  attr_reader :purchase_imports
  helper_method :purchase_imports

  def process_file
    @purchase_imports = PurchaseImport.new(params[:file])
  end

  def url_after_save
    if @purchase_imports.save
      @report = ImportReport.create!(@purchase_imports.prepare_report)
      flash[:notice] = "File imported successfully."
      redirect_to import_report_url(@report.id)
    else
      render :new
    end
  end
end