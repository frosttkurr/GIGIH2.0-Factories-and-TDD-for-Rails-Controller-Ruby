class Food < ApplicationRecord
  has_one :categories
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true, comparison: { greater_than_or_equal_to: 0.01 }
  validates :category_id, presence: true, numericality: true, comparison: { greater_than: 0 }

  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end
end
