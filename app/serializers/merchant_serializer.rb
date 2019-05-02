class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  has_many :items
  has_many :invoices

  # attribute :total_revenue do
  #
  # end

end
