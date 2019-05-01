class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name

  def self.most_revenue(count)
    joins(invoices: :invoice_items).select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").group(:id).order("revenue DESC").limit(count)
  end

  def self.most_items(count)
    joins(invoices: :invoice_items).select("merchants.*, SUM(invoice_items.quantity) AS total").group(:id).order("total DESC").limit(count)
  end

  def self.date_revenue(date)
    beginning = date.to_datetime
    end_of_day = beginning + 1.day - 1.minute
    joins(invoices: :invoice_items).select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").where("invoice_items.updated_at BETWEEN ? AND ?", beginning, end_of_day).group(:id).order("revenue DESC")
  end
end
