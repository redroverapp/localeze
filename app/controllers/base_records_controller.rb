class BaseRecordsController < ApplicationController
  before_filter :authenticate_user!

  # CRUD ===========================================================================================
  def index
    params[:by] ||= 'pid'
    @base_records = BaseRecord.order_by(ScaffoldLogic.mongoid_sorter_from(params[:by], params[:dir])).limit(100)
    @base_records = @base_records.pid params[:q] unless params[:q].blank?
    @base_record_fields = LocalezeImport::MODEL_ATTRIBUTES[BaseRecord][:fields][0..15]
  end

  def show
    @base_record = BaseRecord.find params[:id]
  end
end