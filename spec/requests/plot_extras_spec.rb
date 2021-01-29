require 'rails_helper'

RSpec.describe "PlotExtras", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/plot_extras/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/plot_extras/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/plot_extras/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/plot_extras/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
