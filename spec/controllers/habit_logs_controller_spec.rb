require "rails_helper"

describe HabitLogsController, type: :controller do
  before do
    coach = create(:coach)
    @habit_description = create(:habit_description,
                                user: coach)
    @user = create(:user)
    sign_in @user
    @habit_log = create_list(:habit_log,
                             2,
                             user: @user,
                             habit_description: @habit_description).first
  end

  describe "GET #index" do
    it "should query 2 HabitLogs" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 HabitLog" do
      get(
        :show,
        id: @habit_log.id)

      expect(json["created_at"]).to eq(@habit_log.created_at.as_json)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create HabitLog" do
        habit_log_attributes =
          attributes_for(:habit_log,
                         habit_description_id: @habit_description.id)
        expect do
          post(
            :create,
            habit_log: habit_log_attributes)
        end.to change(HabitLog, :count).by(1)
      end
    end

    context "with maximum of ten" do
      it "should not create HabitLog" do
        habit_log = create_list(:habit_log, 8,
                                user: @user,
                                habit_description: @habit_description)
        habit_log_attributes = attributes_for(:habit_log)

        expect do
          post(
            :create,
            habit_log: habit_log_attributes)
        end.to change(HabitLog, :count).by(0)
      end
    end

    context "with invalid attributes" do
      it "should not create HabitLog" do
        habit_log_attributes =
          attributes_for(:habit_log, habit_description_id: nil)

        expect do
          post(
            :create,
            habit_log: habit_log_attributes)
        end.to change(HabitLog, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update HabitLog" do
        date = Time.zone.now + rand(1000).minutes
        habit_log_attributes = attributes_for(:habit_log)
        habit_log_attributes[:logged_at] << date

        patch(
          :update,
          id: @habit_log.id,
          habit_log: habit_log_attributes)

        expect(HabitLog.find(@habit_log.id).logged_at).to include(date.to_s)
      end
    end

    context "with invalid attributes" do
      it "should not update HabitLog" do
        habit_log_attributes =
          attributes_for(:habit_log,
                         habit_description_id: nil)
        patch(
          :update,
          id: @habit_log.id,
          habit_log: habit_log_attributes)

        expect(HabitLog.find(@habit_log.id).habit_description_id).to eq(@habit_log.habit_description_id)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with no logging" do
      it "should delete HabitLog" do
        @habit_log[:logged_at] = nil
        @habit_log.save

        expect do
          delete(
            :destroy,
            id: @habit_log.id)
        end.to change(HabitLog, :count).by(-1)
      end
    end

    context "with any logging" do
      it "should not delete HabitLog" do
        date = Time.zone.now + rand(1000).minutes
        @habit_log[:logged_at] << date
        @habit_log.save

        expect do
          delete(
            :destroy,
            id: @habit_log.id)
        end.to change(HabitLog, :count).by(-1)

        expect(HabitLog.where(id: @habit_log.id).unscope(where: :id)).to exist
      end
    end
  end
end
