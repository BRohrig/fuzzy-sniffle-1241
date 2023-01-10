require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "instance methods" do
    before(:all) do
    @chef = Chef.create!(name: "Robert Flay")
    @dish = @chef.dishes.create!(name: "Rotten Migration", description: "This tastes awful")
    @ingredient1 = @dish.ingredients.create!(name: "Sadness", calories: 45)
    @ingredient2 = @dish.ingredients.create!(name: "Avarice", calories: 3)
    @ingredient3 = @dish.ingredients.create!(name: "Despair", calories: 19)
    end
    
    it 'has a method to find the total calories based on ingredients' do
      expect(@dish.calorie_count).to eq(67)
    end


  end
end