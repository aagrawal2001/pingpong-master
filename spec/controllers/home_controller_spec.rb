require "rails_helper"

describe HomeController, type: :controller do
  let(:user) { create(:user) }

  it "should redirect if get index and logged out" do
    get :index
    expect(response).to have_http_status(302)
  end

  it "should get index if logged in" do
    sign_in user

    get :index
    expect(response).to have_http_status(200)
  end
end
