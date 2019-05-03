class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :unit_price

  belongs_to :invoice
  belongs_to :item
end
