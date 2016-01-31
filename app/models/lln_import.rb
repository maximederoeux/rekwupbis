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

end
