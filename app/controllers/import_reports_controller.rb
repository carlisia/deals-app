class ImportReportsController < ApplicationController

  def index
    @reports = ImportReport.all
  end

  def show
    @report = ImportReport.find(params[:id])
  end

  private
  attr_reader :report, :reports
  helper_method :report, :reports
end