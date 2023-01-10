require 'rails_helper'

RSpec.describe 'chef_ingredients index page' do
  before(:all) do
    @chef = Chef.create!(name: "Robert Flay")
    @dish = @chef.dishes.create!(name: "Rotten Migration", description: "This tastes awful")
    @dish2 = @chef.dishes.create!(name: "Humble Pie", description: "You thought you knew what you were doing")
    @ingredient1 = Ingredient.create!(name: "Sadness", calories: 1)
    @ingredient2 = Ingredient.create!(name: "Avarice", calories: 3)
    @ingredient3 = Ingredient.create!(name: "Despair", calories: 4)
    @ingredient4 = @dish.ingredients.create!(name: "food", calories: 90)
    @ingredient5 = Ingredient.create!(name: "water", calories: 0)
    @dish.ingredients.push(@ingredient3)
    @dish.ingredients.push(@ingredient2)
    @dish2.ingredients.push(@ingredient1)
    @dish2.ingredients.push(@ingredient3)
  end

  it 'displays the chefs name and header' do
    visit chef_ingredients_path(@chef.id)
    expect(page).to have_content("#{@chef.name}'s Ingredients List:")
  end

  it 'displays a unique list of the ingredients used by that chef' do
    visit chef_ingredients_path(@chef.id)

    within "#ingredients" do
      expect(page).to have_content("#{@ingredient1.name} #{@ingredient2.name} #{@ingredient3.name} #{@ingredient4.name}")
      expect(page).to_not have_content(@ingredient5.name)

    end

  end



end