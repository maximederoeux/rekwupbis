class LlnImportsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@lln_imports = LlnImport.all.order('id ASC')
  	@new_offer = Offer.new


  end

  def pdf
    @lln_imports = LlnImport.all.order('id ASC')
  end

  def import
  	LlnImport.import(params[:file])
  	redirect_to lln_imports_path, notice: "LLN imported sucessfully"
  end
 

  def destroy
  	@lln_import = LlnImport.find(params[:id])
    @lln_import.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: t("Import destroyed") }
      format.json { head :no_content }
    end
  end

end
