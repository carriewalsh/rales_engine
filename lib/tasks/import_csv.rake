namespace :import do
  desc "rake import data from customers"
  task customers_data: :environment do
    require "csv"
    CSV.foreach("./seeds/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  desc "rake import data from invoice_items"
  task invoice_items_data: :environment do
    require "csv"
    CSV.foreach("./seeds/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "rake import data from invoices"
  task invoices_data: :environment do
    require "csv"
    CSV.foreach("./seeds/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "rake import data from items"
  task items_data: :environment do
    require "csv"
    CSV.foreach("./seeds/items.csv", headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

  desc "rake import data from merchants"
  task merchants_data: :environment do
    require "csv"
    CSV.foreach("./seeds/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "rake import data from transaction"
  task transaction_data: :environment do
    require "csv"
    CSV.foreach("./seeds/transaction.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
