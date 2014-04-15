class PurchaseImportsController < ApplicationController

  def create
    if file
      @purchase_imports = PurchaseImport.new(file)
      url_after_save
    else
      redirect_to new_purchase_import_url, alert: "File incorrectly formated or no file selected."
    end
  end

  private
  attr_reader :purchase_imports
  helper_method :purchase_imports

  def url_after_save
    if @purchase_imports.save
      flash[:notice] = "File imported successfully."
      redirect_to import_report_url(report.id)
    else
      render :new
    end
  end

  def report
    ImportReport.create!(@purchase_imports.report_data)
  end

  def file
    params[:file]
  end
end