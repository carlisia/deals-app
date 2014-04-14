class PurchaseImportsController < ApplicationController

  def create
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
    @report = ImportReport.new
    @purchase_imports = PurchaseImport.new(params[:file], @report)
  end

  def url_after_save
    if @purchase_imports.save
      prepare_report
      flash[:notice] = "File imported successfully."
      redirect_to import_report_url(@report.id)
    else
      render :new
    end
  end

  def prepare_report
    @purchase_imports.prepare_report
    @report.save!
  end

  def file
    params[:file]
  end
end