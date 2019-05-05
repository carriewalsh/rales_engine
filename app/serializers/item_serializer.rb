class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  attribute :unit_price do |object|
    (object.unit_price/100.00).round(2).to_s
  end
end
