require "rails_helper"

describe "Registration", type: :request do
  describe "when user signs up with valid credentials" do
    before do
      user_attributes = attributes_for(:user,
                                       confirm_success_url: "/")
      post(
        "/api/auth",
        user_attributes)
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end

    it "should respond with authorization headers" do
      expect(number_of_headers(response.headers.keys)).to eq(3)
    end

    it "should respond with id of new user" do
      expect(json.key?("data") && json["data"].key?("id")).to eq(true)
    end
  end

  describe "when user signs up with invalid credentials" do
    before do
      user_attributes = attributes_for(:user,
                                       password: "",
                                       confirm_success_url: "/")
      post(
        "/api/auth",
        user_attributes)
    end

    it "should respond with status 403" do
      expect(response.status).to eq(403)
    end

    it "should respond with errors" do
      expect(json.keys).to include("errors")
    end
  end
end

def number_of_headers(headers)
  headers.inject(0) do |count, header|
    count += 1 if ["access-token", "client", "uid"].include?(header.downcase)
    count
  end
end
