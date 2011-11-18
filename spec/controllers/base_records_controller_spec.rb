require 'spec_helper'

describe BaseRecordsController do
  before :each do
    @base_record = BaseRecord.new
    BaseRecord.stubs(:find).returns(@base_record)
    BaseRecord.any_instance.stubs(:save).returns(true)
    BaseRecord.any_instance.stubs(:to_param).returns('1')
  end

  it 'gets index action' do
    BaseRecord.stubs(:find).returns([@base_record])
    get :index
    response.should render_template(:index)
  end

  it 'gets show action' do
    get :show, :id => 1
    response.should render_template(:show)
  end
end
