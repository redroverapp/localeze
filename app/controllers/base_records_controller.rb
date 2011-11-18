class BaseRecordsController < ApplicationController
  before_filter :authenticate_user!

  # CRUD ===========================================================================================
  def index
    @base_records = BaseRecord.order_by ScaffoldLogic.mongoid_sorter_from(params[:by], params[:dir])
    @fields = LocalezeImport::MODEL_ATTRIBUTES[BaseRecord][:fields][0..15]
  end

  def show
    @base_record = BaseRecord.find params[:id]
  end
end