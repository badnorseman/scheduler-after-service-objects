require 'rails_helper'

describe TagsController, type: :controller do
  before do
    admin = create(:administrator)
    sign_in admin
    @tag = create_list(:tag,
                       2,
                       user: admin).first
  end

  describe "GET #index" do
    it "should query 2 Tags" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 Tag" do
      get(
        :show,
        id: @tag.id)

      expect(json["name"]).to eq(@tag.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create Tag" do
        tag_attributes =
          attributes_for(:tag)

        expect do
          post(
            :create,
            tag: tag_attributes)
        end.to change(Tag, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Tag" do
        tag_attributes =
          attributes_for(:tag, name: nil)

        expect do
          post(
            :create,
            tag: tag_attributes)
        end.to change(Tag, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update Tag" do
        name = "Name #{rand(100)}"

        patch(
          :update,
          id: @tag.id,
          tag: { name: name } )

        expect(Tag.find(@tag.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update Tag" do
        name = "too long name" * 100

        patch(
          :update,
          id: @tag.id,
          tag: { name: name } )

        expect(Tag.find(@tag.id).name).to eq(@tag.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Tag when not in use" do
      expect do
        delete(
          :destroy,
          id: @tag.id)
      end.to change(Tag, :count).by(-1)
    end

    it "should not delete Tag when in use" do
      create(:tagging,
             tag: @tag)

      expect do
        delete(
          :destroy,
          id: @tag.id)
      end.to change(Tag, :count).by(-1)

      expect(Tag.where(id: @tag.id).unscope(where: :id)).to exist
    end
  end
end
