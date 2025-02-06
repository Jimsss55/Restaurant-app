class MenuItem < ApplicationRecord
  has_many :order_items
  has_many :customers, through: :order_items

  validates :menu_items, presence: true
  validates :menu_item_price, presence: true, numericality: {
    greater_than_or_equal_to: 1 }

  def self.search_by_menu_name(menu_name_query)
    if menu_name_query.present?
      where("menu_items LIKE ? ", "%#{menu_name_query}%")
    else
      all
    end
  end
end
