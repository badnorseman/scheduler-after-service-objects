require "rails_helper"

describe Product, type: :request do
  before do
    @coach = create(:coach)
    @tokens = @coach.create_new_auth_token("test")
    @product = create_list(:product,
                           2,
                           user: @coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/users/#{@coach.id}/products.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/users/#{@coach.id}/products.json",
        {},
        @tokens)
    end

    it "should respond with an array of 2 Products" do
      expect(json.count).to eq 2
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/users/#{@coach.id}/products/#{@product.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 Product" do
      expect(json["name"]).to eq(@product.name)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @product_attributes = attributes_for(:product)

        post(
          "/api/users/#{@coach.id}/products.json",
          { product: @product_attributes },
          @tokens)
      end

      it "should respond with created Product" do
        expect(json["name"]).to eq @product_attributes[:name]
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
        product_attributes =
          attributes_for(:product, name: nil)

        post(
          "/api/users/#{@coach.id}/products.json",
          { product: product_attributes },
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
          "/api/users/#{@coach.id}/products/#{@product.id}.json",
          { product: { name: @name } },
          @tokens)
      end

      it "should respond with updated Product" do
        expect(Product.find(@product.id).name).to eq(@name)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        name = "too long name" * 100

        patch(
          "/api/users/#{@coach.id}/products/#{@product.id}.json",
          { product: { name: name } },
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
        "/api/users/#{@coach.id}/products/#{@product.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
