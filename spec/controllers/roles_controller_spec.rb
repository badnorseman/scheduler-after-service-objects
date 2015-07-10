require "rails_helper"

describe RolesController, type: :controller do
  before do
    admin = create(:administrator)
    sign_in admin
    @role = create(:role)
  end

  describe "GET #index" do
    it "should query 2 Roles" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 Role" do
      get(
        :show,
        id: @role.id)

      expect(json["name"]).to eq(@role.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create Role" do
        role_attributes =
          attributes_for(:role, name: "#{rand(100)}")

        expect do
          post(
            :create,
            role: role_attributes)
        end.to change(Role, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Role" do
        role_attributes =
          attributes_for(:role, name: nil)
        expect do
          post(
            :create,
            role: role_attributes)
        end.to change(Role, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update Role" do
        name = "Name #{rand(100)}"

        patch(
          :update,
          id: @role.id,
          role: { name: name } )

        expect(Role.find(@role.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update Role" do
        name = "too long name" * 10

        patch(
          :update,
          id: @role.id,
          role: { name: name } )

        expect(Role.find(@role.id).name).to eq(@role.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Role" do
      expect do
        delete(
          :destroy,
          id: @role.id)
      end.to change(Role, :count).by(-1)
    end
  end
end
