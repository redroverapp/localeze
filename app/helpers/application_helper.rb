module ApplicationHelper
  include ActionControllerMixin
  include ScaffoldLogic::Helper

  def admin_breadcrumbs
    add_breadcrumb 'Home', base_records_path
    add_breadcrumb @base_record.businessname, @base_record if @base_record
    @breadcrumbs.uniq
  end
end