class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :result, :credit_card_number, :invoice_id

  belongs_to :invoice
end
