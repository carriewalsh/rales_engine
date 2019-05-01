class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :first_name, :last_name

  def self.favorite_customer(merchant_id)
    joins(invoices: :transactions).select("customers.*, COUNT(transactions.id) AS total").where("invoices.merchant_id": merchant_id).group(:id).order("total DESC").first
  end
end
