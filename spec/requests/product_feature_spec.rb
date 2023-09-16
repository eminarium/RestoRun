RSpec.describe Product, type: :request do

  let(:user) { create(:user) }

  context "When the restaurant is not yet created" do
    it "renders the index page with success" do
      sign_in user
      get products_path

      expect(response).to have_http_status(200)
    end

    it "does not render 'New Product' button on the page" do
      sign_in user
      get products_path

      expect(response.body).to_not include('New Product')
    end

    it "renders the 'Create a Restaurant first' alert" do
      sign_in user
      get products_path

      expect(response.body).to include('Please, add a Restaurant info first')
    end
  end

  context "When the restaurant is already created" do
    it "renders the index page with success" do
      sign_in user
      get products_path
      
      expect(response).to have_http_status(:ok)
    end

    it "does not renders the 'New Product' button on the page if no category is created" do
      sign_in user
      create(:restaurant, user_id: user.id)
      get products_path

      expect(response.body).to_not include('New Product')
    end

    it "renders the 'New Product' button on the page if category is created" do
      sign_in user
      restaurant = create(:restaurant, user_id: user.id)
      create(:category, restaurant_id: restaurant.id)
      get products_path

      expect(response.body).to include('New Product')
    end

    it "creates a Product with valid attributes" do
      sign_in user
      restaurant = create(:restaurant, user_id: user.id)
      category = create(:category, restaurant_id: restaurant.id)
      new_product = create(:product, category_id: category.id, restaurant_id: restaurant.id)
      get products_path

      expect(response.body).to include(new_product.title)
    end

    it "updates a Product with valid attributes" do
      sign_in user
      restaurant = create(:restaurant, user_id: user.id)
      category = create(:category, restaurant_id: restaurant.id)
      new_product = create(:product, category_id: category.id, restaurant_id: restaurant.id)
      get products_path

      expect(response.body).to include(new_product.title)

      put product_path(new_product), params: { product: { title: "Updated Product title"} }
      get products_path

      expect(response.body).to include("Updated Product title")
      expect(response.body).to_not include(new_product.title)
    end
  end

end