require 'rails_helper'

RSpec.describe GroupEventsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # GroupEvent. As you add validations to GroupEvent, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { name: 'aaa', location: 'bbb', description: 'dddd', start_date: '2017-10-31', duration: 3 }
  end

  let(:invalid_attributes) do
    { name: nil, location: nil, description: '', start_date: 'asasas', duration: 3 }
  end


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GroupEventsController. Be sure to keep this updated too.
  let(:valid_session) {{}}

  describe "GET #index" do
    it "returns a success response" do
      GroupEvent.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      group_event = GroupEvent.create! valid_attributes
      get :show, params: {id: group_event.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new GroupEvent" do
        expect {
          post :create, params: {group_event: valid_attributes}, session: valid_session
        }.to change(GroupEvent, :count).by(1)
      end

      it "renders a JSON response with the new group_event" do

        post :create, params: {group_event: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(group_event_url(GroupEvent.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new group_event" do

        post :create, params: {group_event: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { published: true, duration: 5, end_date: '2017-11-11'}
      }

      it "updates the requested group_event" do
        group_event = GroupEvent.create! valid_attributes
        put :update, params: {id: group_event.to_param, group_event: new_attributes}, session: valid_session
        group_event.reload
        expect(group_event.duration).to eq(new_attributes[:duration])
        expect(group_event.end_date).to eq(new_attributes[:end_date])
        expect(group_event.start_date).to eq('2017-11-6')
      end

      it "renders a JSON response with the group_event" do
        group_event = GroupEvent.create! valid_attributes

        put :update, params: {id: group_event.to_param, group_event: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the group_event" do
        group_event = GroupEvent.create! valid_attributes

        put :update, params: {id: group_event.to_param, group_event: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested group_event" do
      group_event = GroupEvent.create! valid_attributes
      expect {
        delete :destroy, params: {id: group_event.to_param}, session: valid_session
      }.to change(GroupEvent, :count).by(-1)
    end
  end

end
