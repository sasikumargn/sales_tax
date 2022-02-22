class Cart < ApplicationRecord
  has_many :items

  validates_presence_of :currency_type
  validates_presence_of :items

  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  enum currency_type: [:EUR, :USD, :INR]

  FIXERACCESSKEY = 'df3db89847c9cddc94ebe14a2e75d1df'

  def sales_tax
    sales_tax = 0.0
    items.map do |item|
      sales_tax+=item.sales_tax
    end
    sales_tax
  end

  def total_cost
    total_cost = 0.0
    items.map do |item|
      total_cost+=item.price_with_tax
    end
    total_cost
  end   

end