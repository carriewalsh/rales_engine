class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.favorite_customer(merchant)
    joins(invoices: :transactions).select("customers.*, COUNT(transactions.id) AS total").where("transactions.result = ? AND invoices.merchant_id= ? ","success", merchant).group(:id).order("total DESC").first
  end

  def self.pending_customers(merchant)
    distinct.left_joins(invoices: [:merchant, :transactions]).where("merchants.id": merchant).where.not("invoices.id IN (SELECT transactions.invoice_id FROM transactions WHERE transactions.result = 'success')")
  end

  def transactions
    Transaction.joins(:invoice).where("invoices.customer_id": self.id)
  end
end
