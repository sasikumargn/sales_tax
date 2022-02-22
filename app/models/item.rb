class Item < ApplicationRecord
  belongs_to :cart, optional: true

  validates_presence_of :quantity, :description, :price

  TAXTYPES = {
      NA: 0,
      BASIC: 0.10,
      IMPORTED: 0.05,
      BOTH: 0.15
    }

    def price_with_tax
      round_of_tax(sales_tax + quantity_price.to_f)
    end

    def sales_tax
      round_of_tax(tax_type * quantity_price.to_f)
    end

    def quantity_price
      quantity.to_f * price.to_f
    end

    def imported?
      description =~ /imported/i
    end

    def exempted?
      return false if description.blank?
      ['book','chocolate','pills'].any? { |word| description.include?(word) }
    end

    def tax_type
      if imported? && !exempted?
        TAXTYPES[:BOTH]
      elsif imported? && exempted?
        TAXTYPES[:IMPORTED]
      elsif !imported? && !exempted?
        TAXTYPES[:BASIC]
      else
        TAXTYPES[:NA]
      end
    end

    private

    def round_of_tax(tax)
      ((tax*100).round/100.0)
    end

end