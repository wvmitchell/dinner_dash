class Item < ActiveRecord::Base
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :categories, through: :item_categories
  has_many :item_categories
  has_attached_file :image, styles: { small: "200x200" }
  validates_presence_of :title, :description, :price

  def self.active
    where(active: true)
  end

  def update_categories(potential_categories)
    kategories = potential_categories || []
    kategories.each {|cat| categories << Category.find(cat)}
  end

end
