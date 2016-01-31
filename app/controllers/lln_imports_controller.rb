class LlnImportsController < ApplicationController
  def index
  	@lln_imports = LlnImport.all
  end

  def import
  	LlnImport.import(params[:file])
  	redirect_to lln_imports_path, notice: "LLN imported sucessfully"
  	@new_offer = Offer.new
  end
 

  def destroy
  	@lln_import = LlnImport.find(params[:id])
    @lln_import.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: t("nImport destroyed") }
      format.json { head :no_content }
    end
  end

end
