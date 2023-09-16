RSpec.describe Table, type: :request do

  let(:user) { create(:user) }

  context "When a Restaurant is not yet created" do
    it "renders the index page with success" do
      sign_in user
      get tables_path

      expect(response).to have_http_status(:ok)
    end

    it "does not render the 'New Table' button on the page" do
      sign_in user
      get tables_path

      expect(response.body).to_not include("New Table")
    end

    it "renders 'Create a restaurant first' alert on the page" do
      sign_in user
      get tables_path

      expect(response.body).to include('Please, add a Restaurant info first')
    end
  end

  context "When a Restaurant is created" do
    it "renders the index page with success" do
      sign_in user
      get tables_path

      expect(response).to have_http_status(:ok)
    end

    it "renders the 'New Table' button on the page" do
      sign_in user
      create(:restaurant, user_id: user.id)
      get tables_path

      expect(response.body).to include('New Table')
    end

    it "creates a Table with valid attributes" do
      sign_in user
      restaurant = create(:restaurant, user_id: user.id)
      new_table = create(:table, restaurant_id: restaurant.id)
      get tables_path

      expect(response.body).to include(new_table.title)
    end

    it "updates a Table when valid attributes provided" do
      sign_in user
      restaurant = create(:restaurant, user_id: user.id)
      new_table = create(:table, restaurant_id: restaurant.id)
      get tables_path

      expect(response.body).to include(new_table.title)

      put table_path(new_table), params: { table: { title: "Updated Table title" } }
      get tables_path

      expect(response.body).to include("Updated Table title")
      expect(response.body).to_not include(new_table.title)
    end
  end

end