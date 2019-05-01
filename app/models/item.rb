class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates_presence_of :name,
                        :description,
                        :unit_price
  validates_numericality_of :unit_price

  def self.top_by_revenue(count)
    joins(:invoice_items).select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").group(:id).order("revenue DESC").limit(count)
  end

  def self.top_by_quantity(count)
    Item.joins(:invoice_items).select("items.*, SUM(invoice_items.quantity) AS total").group(:id).order("total DESC").limit(count)
  end
end
