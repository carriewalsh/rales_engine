class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions]).select("merchants.*, ROUND(SUM(invoice_items.quantity * invoice_items.unit_price)/100,2) AS revenue").where("transactions.result": 'success').group(:id).order("revenue DESC").limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions]).select("merchants.*, SUM(invoice_items.quantity) AS total").where("transactions.result": 'success').group(:id).order("total DESC").limit(quantity)
  end

  def self.date_revenue(date)
    beginning = date.to_datetime
    end_of_day = beginning + 1.day - 1.second
    Invoice.joins(:invoice_items,:transactions).where("transactions.result = ? AND invoices.updated_at between ? and ?","success",beginning,end_of_day).sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.favorite_merchant(customer_id)
    joins(invoices: :transactions).select("merchants.*, COUNT(transactions.id) AS count").where("invoices.customer_id = ? AND transactions.result = ?", customer_id, "success").group(:id).order("count DESC").first
  end

  def total_revenue
    invoices.joins(:transactions, :invoice_items).where("transactions.result = 'success'").sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def date_revenue(date)
    beginning = date.to_datetime
    end_of_day = beginning + 1.day - 1.second
    invoices.joins(:transactions, :invoice_items).where("transactions.result = ? AND invoices.updated_at between ? and ?","success",beginning,end_of_day).sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
