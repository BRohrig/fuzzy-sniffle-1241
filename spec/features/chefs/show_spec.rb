require 'rails_helper'

RSpec.describe 'chef show page' do
  before(:all) do
    @chef = Chef.create!(name: "Robert Flay")
    @chef2 = Chef.create!(name: "William Flambe")
    @dish = @chef.dishes.create!(name: "Rotten Migration", description: "This tastes awful")
    @dish2 = @chef.dishes.create!(name: "Humble Pie", description: "You thought you knew what you were doing")
    @dish3 = @chef2.dishes.create!(name: "Key Lime Pie", description: "This is delicious")
    @ingredient1 = @dish.ingredients.create!(name: "Sadness", calories: 1)
    @ingredient2 = @dish.ingredients.create!(name: "Avarice", calories: 3)
    @ingredient3 = @dish.ingredients.create!(name: "Despair", calories: 4)
  end

  it 'displays the name of the chef and all their associated dishes' do
    visit chef_path(@chef.id)
    expect(page).to have_content(@chef.name)
    within "#dishes" do
    expect(page).to have_content(@dish.name)
    expect(page).to have_content(@dish2.name)
    end
  end

  it 'has a form to add an existing dish to that chef' do
    visit chef_path(@chef.id)
    expect(page).to have_field :dish_id
    fill_in :dish_id, with: "#{@dish3.id}"
    click_button "Submit"
    expect(current_path).to eq(chef_path(@chef.id))

    within "#dishes" do
      expect(page).to have_content(@dish3.name)
    end
  end

  it 'has a link to the chefs ingredients index page' do
    visit chef_path(@chef.id)
    expect(page).to have_link "Chef's Ingredients", href: chef_ingredients_path(@chef.id)
  end
end