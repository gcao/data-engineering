require 'spec_helper'

describe RawTransactionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    integrate_views

    it "returns http success and show the total amount" do
      post 'create', transactions_file: fixture_file_upload('test.csv', 'text/plain')

      response.should be_success
      response.body.should include "$95.00"
    end
  end

end
