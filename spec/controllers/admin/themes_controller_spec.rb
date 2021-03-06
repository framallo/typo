require File.dirname(__FILE__) + '/../../spec_helper'
require 'admin/themes_controller'

# Re-raise errors caught by the controller.
class Admin::ThemesController; def rescue_action(e) raise e end; end

describe Admin::ThemesController, 'ported from the tests' do
  integrate_views

  before do
    request.session = { :user => users(:tobi).id }
  end

  # Replace this with your real tests.
  it "test_index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:themes)
  end

  it "test_switchto" do
    get :switchto, :theme => 'typographic'
    assert_response :redirect, :action => 'index'
  end

  it "test_preview" do
    get :preview, :theme => 'typographic'
    assert_response :success
  end
end
