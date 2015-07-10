require "rails_helper"

describe "Session", type: :request do
  describe "when user logs in" do
    context "with valid credentials" do
      before do
        user = create(:user)

        post(
          "/api/auth/sign_in",
          { email: user.email,
            password: user.password } )
      end

      it "should respond with status 200" do
        expect(response.status).to eq(200)
      end

      it "should respond with Authorization headers" do
        expect(number_of_headers(response.headers.keys)).to eq(3)
      end
    end

    context "with invalid credentials" do
      before do
        user_attributes =
          attributes_for(:user, password: rand(1000))

        post(
          "/api/auth/sign_in",
          { email: user_attributes[:email],
           password: user_attributes[:password] } )
      end

      it "should respond with status 401" do
        expect(response.status).to eq(401)
      end

      it "shouldn't respond with Authorization headers" do
        expect(number_of_headers(response.headers.keys)).to eq(0)
      end
    end
  end

  describe "when user logs out" do
    before do
      @user = create(:user)
      @tokens = @user.create_new_auth_token("test")

      delete(
        "/api/auth/sign_out",
        {},
        @tokens)
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end

    it "shouldn't respond with Authorization headers" do
      expect(number_of_headers(response.headers.keys)).to eq(0)
    end

    context "when Authorization tokens are expired" do
      before do
        get(
          "/api/users/#{@user.id}",
          {},
          @tokens)
      end

      it "should respond with status 401" do
        expect(response.status).to eq(401)
      end
    end
  end
end

def number_of_headers(headers)
  headers.inject(0) do |count, header|
    count += 1 if ["access-token", "client", "uid"].include?(header.downcase)
    count
  end
end
