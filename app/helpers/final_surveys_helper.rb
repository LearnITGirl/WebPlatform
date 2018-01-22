module FinalSurveysHelper

  def temporary_file_name_and_size(file)
    if file.filename.present? && file.size.present?
      "#{file.filename} (#{(file.size.to_f/(1024*1024)).round(2)}mb)"
    end
  end
end
