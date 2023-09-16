RSpec.describe Restaurant, type: :request do
  
  let(:user) { create(:user) }

  it "shows no restaurant info and shows 'New Restaurant' button on the page, before creating a restaurant" do
    sign_in user
    get manager_dashboard_path(user)

    expect(response.body).to include("New Restaurant")
  end

  it "shows restaurant info on the manager dashboard, after being created" do
    sign_in user
    new_restaurant = create(:restaurant, user_id: user.id)
    get manager_dashboard_path(user)

    expect(response.body).to include(new_restaurant.title)
    expect(response.body).to_not include("New Restaurant")
  end

  it "creates a restaurant when valid attributes provided" do
    sign_in user
    post restaurants_path, params: { restaurant: { title: "My Restaurant", user_id: user.id } }
    get manager_dashboard_path(user)

    expect(response.body).to include(Restaurant.first.title)
  end

  it "updates restaurant info when valid attributes provided" do
    sign_in user
    post restaurants_path, params: { restaurant: { title: "My RestoRun", user_id: user.id } }
    get manager_dashboard_path(user)

    resto = Restaurant.first

    expect(response.body).to include(resto.title)

    put restaurant_path(resto), params: { restaurant: { title: "Updated Restorun" } }
    get manager_dashboard_path(user)

    expect(response.body).to include("Updated Restorun")
    expect(response.body).to_not include(resto.title)
  end
end