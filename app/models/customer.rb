class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.favorite_customer(merchant)
    joins(invoices: :transactions).select("customers.*, COUNT(transactions.id) AS total").where("invoices.merchant_id": merchant).group(:id).order("total DESC").first
  end

  def self.pending_customers(merchant)
    x = distinct.joins(invoices: [:merchant, :transactions]).where("merchants.id": merchant).where.not("invoices.id IN (SELECT transactions.invoice_id FROM transactions WHERE transactions.result = 'success')")
  end
end
