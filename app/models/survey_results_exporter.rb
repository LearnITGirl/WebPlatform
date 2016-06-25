class SurveyResultsExporter

  def initialize
    Spreadsheet.client_encoding = 'UTF-8'
    @xls_file = Spreadsheet::Workbook.new
  end

  def to_xls
    populate_a_worksheet(MentorMidtermEvaluation.all, 'Midterm mentors survey', %w{extra_info})
    populate_a_worksheet(MenteeMidtermEvaluation.all, 'Midterm mentees survey', %w{extra_info})
    populate_a_worksheet(FinalSurvey.all, 'Final survey', %w{mentee_impression  mentor_impression mentee_expectations 
                                                             mentor_expectations mentee_project_summary
                                                             mentor_project_summary mentee_feedback mentor_feedback} )

    @xls_file
  end

  private

  def populate_a_worksheet(data, worksheet_name, columns)
    worksheet = @xls_file.create_worksheet(name: worksheet_name)
    worksheet.row(0).concat columns.map{|name| name.titleize}

    format = Spreadsheet::Format.new weight: :bold
    worksheet.row(0).default_format = format

    generate_rows(data, columns).each_with_index do |content, index|
      worksheet.row(index+1).concat(content)
    end
  end

  def generate_rows(data, columns)
    rows = []
    data.each do |record|
      row = []
      columns.each do |column|
         row << record[column]
      end

      if row.present? && !row.compact.reject { |c| c.empty? }.blank?
        rows << row
      end
    end
    rows
  end
end

