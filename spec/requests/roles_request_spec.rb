require "rails_helper"

describe Role, type: :request do
  before do
    admin = create(:administrator)
    @tokens = admin.create_new_auth_token("test")
    @role = create(:role)
  end

  describe "Unauthorized request" do
    before do
      get "/api/roles.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/roles.json",
        {},
        @tokens)
    end

    it "should respond with array of 2 Roles" do
      expect(json.count).to eq 2
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/roles/#{@role.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 Role" do
      expect(json["name"]).to eq(@role.name)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @role_attributes =
          attributes_for(:role, name: "Guest")

        post(
          "/api/roles.json",
          { role: @role_attributes },
          @tokens)
      end

      it "should respond with created Role" do
        expect(json["name"]).to eq @role_attributes[:name]
      end

      it "should respond with new id" do
        expect(json.keys).to include("id")
      end

      it "should respond with status 201" do
        expect(response.status).to eq 201
      end
    end

    context "with invalid attributes" do
      before do
        role_attributes =
          attributes_for(:role, name: nil)

        post(
          "/api/roles.json",
          { role: role_attributes },
          @tokens)
      end

      it "should respond with errors" do
        expect(json.keys).to include("errors")
      end

      it "should respond with status 422" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before do
        @name = "Role #{rand(24)}"

        patch(
          "/api/roles/#{@role.id}.json",
          { role: { name: @name } },
          @tokens)
      end

      it "should respond with updated Role" do
        expect(json["name"]).to eq @name
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        name = "too long name" * 100

        patch(
          "/api/roles/#{@role.id}.json",
          { role: { name: name } },
          @tokens)
      end

      it "should respond with errors" do
        expect(json.keys).to include("errors")
      end

      it "should respond with status 422" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      delete(
        "/api/roles/#{@role.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
