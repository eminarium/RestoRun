RSpec.describe Category, type: :request do

  let(:user) { create(:user) }

  context "When the Restaurant is not yet created" do
    it "renders the index page with success" do
      sign_in user
      get categories_path

      expect(response).to have_http_status(200)
    end    

    it "does not render 'New Category' button on the page" do
      sign_in user
      get categories_path

      expect(response.body).to_not include('New Category')
    end

    it "renders the 'Create a Restaurant first' alert" do
      sign_in user
      get categories_path

      expect(response.body).to include('Please, add a Restaurant info first')
    end
  end

  context "When Restaurant is created" do
    it "renders the index page with success" do
      sign_in user
      create(:restaurant, user_id: user.id)
      get categories_path

      expect(response).to have_http_status(200)
    end

    it "renders the 'New Category' button on the page" do
      sign_in user
      create(:restaurant, user_id: user.id)
      get categories_path

      expect(response.body).to include('New Category')
    end

    it "creates a Category when valid attributes provided" do
      sign_in user
      restaurant = create(:restaurant, user_id: user.id)
      new_category = create(:category, restaurant_id: restaurant.id)
      get categories_path

      expect(response.body).to include(new_category.title)
    end
  end

end