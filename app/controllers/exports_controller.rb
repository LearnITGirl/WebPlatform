class ExportsController < ApplicationController
  def surveys
    respond_to do |format|
      format.xls {
        spreadsheet = StringIO.new
        SurveyResultsExporter.new.to_xls.write spreadsheet
        send_data spreadsheet.string, :filename => "litg_survey.xls", :type =>  "application/vnd.ms-excel"
      }
    end
  end

  def final_results
    respond_to do |format|
      format.csv do
        exporter = FinalResultsExporter.new
        send_data exporter.to_csv, filename: "passing_users.csv"
      end
    end
  end
end
