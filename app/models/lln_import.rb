class LlnImport < ActiveRecord::Base

	require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      lln_import_hash = row.to_hash
      lln_import = LlnImport.where(id: lln_import_hash["id"])

      if lln_import.count == 1
        lln_import.first.update_attributes(lln_import_hash)
      else
        LlnImport.create!(lln_import_hash)
      end # end if !lln_import.nil?
    end # end CSV.foreach
  end # end self.import(file)


  def total_delivery
    lln_twentyfive + lln_fifty + lln_litre + empty_box + kpt_box + return_box
  end

  def current_year
    if Date.today >= Date.parse("01-09-2015") && Date.today <= Date.parse("30-06-2016")
      2015
    elsif Date.today >= Date.parse("01-09-2016") && Date.today <= Date.parse("30-06-2017")
      2016
    elsif Date.today >= Date.parse("01-09-2017") && Date.today <= Date.parse("30-06-2018")
      2017
    elsif Date.today >= Date.parse("01-09-2018") && Date.today <= Date.parse("30-06-2019")
      2018
    elsif Date.today >= Date.parse("01-09-2019") && Date.today <= Date.parse("30-06-2020")
      2019
    elsif Date.today >= Date.parse("01-09-2020") && Date.today <= Date.parse("30-06-2021")
      2020
    elsif Date.today >= Date.parse("01-09-2021") && Date.today <= Date.parse("30-06-2022")
      2021
    elsif Date.today >= Date.parse("01-09-2022") && Date.today <= Date.parse("30-06-2023")
      2022
    end
  end
  

end
