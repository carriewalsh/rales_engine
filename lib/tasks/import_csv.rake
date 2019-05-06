require "csv"

namespace :import do
  desc "rake import data from customers"
  task customer: :environment do
    CSV.foreach("./lib/seeds/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "rake import data from invoice_items"
  task invoice: :environment do
    CSV.foreach("./lib/seeds/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "rake import data from invoices"
  task invoice: :environment do
    CSV.foreach("./lib/seeds/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "rake import data from items"
  task item: :environment do
    CSV.foreach("./lib/seeds/items.csv", headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "rake import data from merchants"
  task merchant: :environment do
    CSV.foreach("./lib/seeds/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "rake import data from transactions"
  task transaction: :environment do
    CSV.foreach("./lib/seeds/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
