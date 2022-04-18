require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'is valid with a name, a description, a price and a category' do
    expect(FactoryBot.build(:food)).to be_valid
  end

  it 'is invalid without a name' do
    food = FactoryBot.build(:food, name: nil)
    food.valid?
    expect(food.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a description' do
    food = FactoryBot.build(:food, description: nil)
    food.valid?
    expect(food.errors[:description]).to include("can't be blank")
  end

  it 'is invalid without a price' do
    food = FactoryBot.build(:food, price: nil)
    food.valid?
    expect(food.errors[:price]).to include("can't be blank")
  end

  it 'is invalid with a duplicate name' do
    food1 = FactoryBot.create(:food, name: "Nasi Uduk")
    food2 = FactoryBot.build(:food, name: "Nasi Uduk")
    food2.valid?
    expect(food2.errors[:name]).to include("has already been taken")
  end

  describe 'self#by_letter' do
    it 'should return foods with specified letter' do
      food1 = FactoryBot.create(:food, name: "Nasi Uduk")
      food2 = FactoryBot.create(:food, name: "Kerak Telor")
      food3 = FactoryBot.create(:food, name: "Nasi Semur Jengkol")
      expect(Food.by_letter("N")).to eq([food3, food1])
    end
  end

  it 'is invalid with non numeric values for price' do
    food = FactoryBot.build(:food, price: "ASJDA&!@!")
    food.valid?
    expect(food.errors[:price]).to include("is not a number")
  end
  
  it 'is invalid with price less than 0.01' do
    food = FactoryBot.build(:food, price: 0.00)
    food.valid?
    expect(food.errors[:price]).to include("must be greater than or equal to 0.01")
  end

  it 'is invalid without a category' do
    food = FactoryBot.build(:food, category_id: nil)
    food.valid?
    expect(food.errors[:category_id]).to include("can't be blank")
  end

  it 'is invalid with non numeric values for category id' do
    food = FactoryBot.build(:food, category_id: "Dessert")
    food.valid?
    expect(food.errors[:category_id]).to include("is not a number")
  end

  it 'is invalid with category id equal to 0' do
    food = FactoryBot.build(:food, category_id: 0)
    food.valid?
    expect(food.errors[:category_id]).to include("must be greater than 0")
  end
end