require "rails_helper"

describe Tag, type: :request do
  before do
    admin = create(:administrator)
    @tokens = admin.create_new_auth_token("test")
    @tag = create_list(:tag,
                       2,
                       user: admin).first
  end

  describe "Unauthorised request" do
    before do
      get "/api/tags.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/tags.json",
        {},
        @tokens)
    end

    it "should respond with array of 2 tags" do
      expect(json.count).to eq 2
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/tags/#{@tag.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 Tag" do
      expect(json["name"]).to eq(@tag.name)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @tag_attributes = attributes_for(:tag)

        post(
          "/api/tags.json",
          { tag: @tag_attributes },
          @tokens)
      end

      it "should respond with created Tag" do
        expect(json["name"]).to eq @tag_attributes[:name]
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
        @tag_attributes =
          attributes_for(:tag, name: nil)

        post(
          "/api/tags.json",
          { tag: @tag_attributes },
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
        @name = "Name #{rand(100)}"

        patch(
          "/api/tags/#{@tag.id}.json",
          { tag: { name: @name } },
          @tokens)
      end

      it "should respond with updated Tag" do
        expect(Tag.find(@tag.id).name).to eq(@name)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        name = "too long name" * 100

        patch(
          "/api/tags/#{@tag.id}.json",
          { tag: { name: name } },
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
        "/api/tags/#{@tag.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
