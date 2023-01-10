require 'rails_helper'

RSpec.describe 'dish show page' do
  before(:all) do
    @chef = Chef.create!(name: "Robert Flay")
    @dish = @chef.dishes.create!(name: "Rotten Migration", description: "This tastes awful")
    @ingredient1 = @dish.ingredients.create!(name: "Sadness", calories: 1)
    @ingredient2 = @dish.ingredients.create!(name: "Avarice", calories: 3)
    @ingredient3 = @dish.ingredients.create!(name: "Despair", calories: 4)
  end

  it 'displays the dishs name and description along with chefs name' do
    visit dish_path(@dish.id)
    expect(page).to have_content(@dish.name)
    expect(page).to have_content(@dish.description)
    expect(page).to have_content(@dish.chef.name)
  end

  it 'displays a list of the ingredients in this dish' do
    visit dish_path(@dish.id)
    within "#ingredients" do
      expect(page).to have_content(@ingredient1.name)
      expect(page).to have_content(@ingredient2.name)
      expect(page).to have_content(@ingredient3.name)
    end
  end

  it 'displays the total calorie count for that dish' do
    visit dish_path(@dish.id)
    within "#calorie_count" do
      expect(page).to have_content("Total Calories: 8")
    end
  end

end