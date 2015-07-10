require "rails_helper"

describe AvailabilitiesController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    @availability = create_list(:availability,
                                2,
                                coach: coach).first
  end

  describe "GET #index" do
    it "should query 2 Availabilities" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 Availability" do
      get(
        :show,
        id: @availability.id)

      expect(json["start_at"]).to eq(@availability.start_at.as_json)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create Availability" do
        availability_attributes = attributes_for(:availability)

        expect do
          post(
            :create,
            availability: availability_attributes)
        end.to change(Availability, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Availability" do
        availability_attributes =
          attributes_for(:availability, start_at: nil)

        expect do
          post(
            :create,
            availability: availability_attributes)
        end.to change(Availability, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update Availability" do
        availability_attributes =
          { start_at: @availability.start_at - 1.day,
            end_at: @availability.end_at + 1.day }

        patch(
          :update,
          id: @availability.id,
          availability: availability_attributes)

        expect(Availability.find(@availability.id).start_at.to_i).to eq(availability_attributes[:start_at].to_i)
      end
    end

    context "with invalid attributes" do
      it "should not update Availability" do
        availability_attributes =
          { start_at: @availability.start_at + 6.days,
            end_at: @availability.start_at + 5.days }

        patch(
          :update,
          id: @availability.id,
          availability: availability_attributes)

        expect(Availability.find(@availability.id).start_at).to eq(@availability.start_at)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Availability" do
      expect do
        delete(
          :destroy,
          id: @availability.id)
      end.to change(Availability, :count).by(-1)
    end
  end
end
