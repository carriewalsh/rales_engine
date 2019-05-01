class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name

  def self.most_revenue(how_many)
    joins(invoices: :invoice_items).select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").group(:id).order("revenue DESC").limit(how_many)
  end
end
