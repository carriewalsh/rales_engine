class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :unit_price, :item_id, :invoice_id

  belongs_to :invoice
  belongs_to :item

  attribute :unit_price do |object|
    (object.unit_price/100.0).to_s
  end
end
