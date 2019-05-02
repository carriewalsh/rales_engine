class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :result

  belongs_to :invoice
end
