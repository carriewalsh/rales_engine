require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Relationships" do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "Business Logic" do
    before :each do
      @merch1 = Merchant.create(name: "Ondrea Chadburn")
      @merch2 = Merchant.create(name: "Raff Faust")
      @merch3 = Merchant.create(name: "Con Chilver")
      @merch4 = Merchant.create(name: "Sibbie Cromett")
      @merch5 = Merchant.create(name: "Rodrique Agott")
      @item1 = @merch1.items.create(name: "W.L. Weller Special Reserve",unit_price: 20000, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.")
      @item2 = @merch2.items.create(name: "W.L. Weller C.Y.P.B.",unit_price: 35000, description:"A light aroma with citrus and oak on the nose. The palate is well rounded and balanced, with a medium-long finish and hints of vanilla.")
      @item3 = @merch3.items.create(name: "Bulleit Bourbon",unit_price: 22000, description:"Medium amber in color, with gentle spiciness and sweet oak aromas. Mid-palate is smooth with tones of maple, oak, and nutmeg. Finish is long, dry, and satiny with a light toffee flavor.")
      @item4 = @merch4.items.create(name: "Stagg Jr.",unit_price: 40000, description:"Rich, sweet, chocolate and brown sugar flavors mingle in perfect balance with the bold rye spiciness. The boundless finish lingers with hints of cherries, cloves and smokiness.")
      @item5 = @merch4.items.create(name: "George T. Stagg",unit_price: 85000, description:"Lush toffee sweetness and dark chocolate with hints of vanilla, fudge, nougat and molasses. Underlying notes of dates, tobacco, dark berries, spearmint and a hint of coffee round out the palate.")
      @item6 = @merch1.items.create(name: "Old Forester 1910 Old Fine Whisky",unit_price: 45000, description:"A double barreled Bourbon creating a smooth mingling of sweet oatmeal raisin cookie and milk chocolate, caramel corn, and evolving spice that lead into a refined, charred oak finish.")
      @item7 = @merch2.items.create(name: "Woodford Reserve Kentucky Straight Bourbon",unit_price: 30000, description:"Clean, brilliant honey amber. Heavy with rich dried fruit, hints of mint and oranges covered with a dusting of cocoa. Faint vanilla and tobacco spice. Rich, chewy, rounded and smooth, with complex citrus, cinnamon and cocoa. Toffee, caramel, chocolate and spice notes abound. Silky smooth, almost creamy at first with a long, warm satisfying tail.")
      @item8 = @merch3.items.create(name: "Four Roses Single Barrel",unit_price: 43000, description:"Dried spice, pear, cocoa, vanilla & maple syrup. Hints of ripe plum & cherries, robust, full body, mellow. Smooth & delicately long.")
      @item9 = @merch4.items.create(name: "Angel's Envy Kentucky Straight Bourbon finished in Port Wine Barrels",unit_price: 55000, description:"Gold color laced with reddish amber hues, nearly copper in tone. You’ll detect notes of subtle vanilla, raisins, maple syrup and toasted nuts. Vanilla, ripe fruit, maple syrup, toast and bitter chocolate. Clean and lingering sweetness with a hint of Madeira that slowly fades.")
      @item10 = @merch5.items.create(name: "Laws Four Grain Straight Bourbon",unit_price: 60000, description:"Aromas of orange blossom compliment notes of black tea, honey, and dusty pepper on the nose. Flavors of pekoe tea, orange peel, cinnamon, and vanilla custard dominate the palate. Hints of sweet tobacco and spice lead to a rich, dry finish.")

      @cust48 = Customer.create(first_name: "Trixie", last_name: "Eronie")
      @cust49 = Customer.create(first_name: "Reynold", last_name: "Beed")
      @cust50 = Customer.create(first_name: "Christiano", last_name: "Trighton")

      @invoice1 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice2 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice3 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice4 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice5 = @merch1.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice6 = @merch2.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice7 = @merch2.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice8 = @merch2.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice9 = @merch2.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice10 = @merch3.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice11 = @merch3.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice12 = @merch3.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice13 = @merch4.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice14 = @merch4.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")
      @invoice15 = @merch5.invoices.create(status: 'shipped', created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")

      @cust48.invoices << @invoice1
      @cust49.invoices << @invoice2
      @cust50.invoices << @invoice3
      @cust48.invoices << @invoice4
      @cust49.invoices << @invoice5
      @cust50.invoices << @invoice6
      @cust48.invoices << @invoice7
      @cust49.invoices << @invoice8
      @cust50.invoices << @invoice9
      @cust48.invoices << @invoice10
      @cust49.invoices << @invoice11
      @cust50.invoices << @invoice12
      @cust48.invoices << @invoice13
      @cust49.invoices << @invoice14
      @cust50.invoices << @invoice15

      @ii1 = @item1.invoice_items.create(quantity: 10, unit_price: 20000, created_at: "2018-04-05 11:50:20",updated_at: "2018-04-13 13:08:43")
      @ii2 = @item2.invoice_items.create(quantity: 10, unit_price: 35000, created_at: "2018-04-06 19:07:44",updated_at: "2018-04-17 00:06:32")
      @ii3 = @item3.invoice_items.create(quantity: 10, unit_price: 22000, created_at: "2018-04-08 22:14:08",updated_at: "2018-04-14 02:03:32")
      @ii4 = @item4.invoice_items.create(quantity: 20, unit_price: 40000, created_at: "2018-04-10 09:04:53",updated_at: "2018-04-12 00:25:16")
      @ii5 = @item5.invoice_items.create(quantity: 20, unit_price: 85000, created_at: "2018-04-05 20:03:19",updated_at: "2018-04-14 11:15:44")
      @ii6 = @item6.invoice_items.create(quantity: 20, unit_price: 45000, created_at: "2018-04-04 10:42:04",updated_at: "2018-04-17 16:22:35")
      @ii7 = @item7.invoice_items.create(quantity: 2, unit_price: 30000, created_at: "2018-04-05 17:57:49",updated_at: "2018-04-14 08:56:26")
      @ii8 = @item8.invoice_items.create(quantity: 2, unit_price: 43000, created_at: "2018-04-09 14:24:00",updated_at: "2018-04-15 03:51:26")
      @ii9 = @item9.invoice_items.create(quantity: 2, unit_price: 55000, created_at: "2018-04-07 23:06:46",updated_at: "2018-04-18 21:14:44")
      @ii10 = @item10.invoice_items.create(quantity: 3, unit_price: 60000, created_at: "2018-04-06 22:35:53",updated_at: "2018-04-13 06:54:52")
      @ii11 = @item1.invoice_items.create(quantity: 3, unit_price: 20000, created_at: "2018-04-06 14:01:25",updated_at: "2018-04-15 15:52:57")
      @ii12 = @item2.invoice_items.create(quantity: 3, unit_price: 35000, created_at: "2018-04-06 11:27:03",updated_at: "2018-04-17 06:47:15")
      @ii13 = @item3.invoice_items.create(quantity: 8, unit_price: 22000, created_at: "2018-04-08 19:05:58",updated_at: "2018-04-13 01:34:26")
      @ii14 = @item4.invoice_items.create(quantity: 8, unit_price: 40000, created_at: "2018-04-08 00:18:25",updated_at: "2018-04-16 00:35:24")
      @ii15 = @item5.invoice_items.create(quantity: 8, unit_price: 85000, created_at: "2018-04-10 07:35:39",updated_at: "2018-04-14 00:28:55")
      @ii16 = @item6.invoice_items.create(quantity: 9, unit_price: 45000, created_at: "2018-04-07 07:18:03",updated_at: "2018-04-15 19:46:36")
      @ii17 = @item7.invoice_items.create(quantity: 9, unit_price: 30000, created_at: "2018-04-10 05:31:25",updated_at: "2018-04-16 18:41:41")
      @ii18 = @item8.invoice_items.create(quantity: 9, unit_price: 43000, created_at: "2018-04-10 20:36:26",updated_at: "2018-04-17 08:54:47")
      @ii19 = @item9.invoice_items.create(quantity: 10, unit_price: 55000, created_at: "2018-04-05 22:49:21",updated_at: "2018-04-18 16:09:57")
      @ii20 = @item10.invoice_items.create(quantity: 10, unit_price: 60000, created_at: "2018-04-04 18:58:29",updated_at: "2018-04-17 15:35:00")
      @ii21 = @item1.invoice_items.create(quantity: 10, unit_price: 20000, created_at: "2018-04-09 05:42:01",updated_at: "2018-04-14 07:19:36")
      @ii22 = @item2.invoice_items.create(quantity: 3, unit_price: 35000, created_at: "2018-04-07 17:46:56",updated_at: "2018-04-12 06:24:31")
      @ii23 = @item3.invoice_items.create(quantity: 3, unit_price: 22000, created_at: "2018-04-08 04:18:00",updated_at: "2018-04-12 16:47:34")
      @ii24 = @item4.invoice_items.create(quantity: 3, unit_price: 40000, created_at: "2018-04-08 20:10:21",updated_at: "2018-04-13 13:04:35")
      @ii25 = @item5.invoice_items.create(quantity: 4, unit_price: 85000, created_at: "2018-04-04 04:22:49",updated_at: "2018-04-15 01:59:53")
      @ii26 = @item6.invoice_items.create(quantity: 4, unit_price: 45000, created_at: "2018-04-07 22:05:59",updated_at: "2018-04-13 12:44:32")
      @ii27 = @item7.invoice_items.create(quantity: 4, unit_price: 30000, created_at: "2018-04-08 21:58:42",updated_at: "2018-04-16 05:50:28")
      @ii28 = @item8.invoice_items.create(quantity: 7, unit_price: 43000, created_at: "2018-04-04 05:39:41",updated_at: "2018-04-14 20:41:48")
      @ii29 = @item9.invoice_items.create(quantity: 7, unit_price: 55000, created_at: "2018-04-05 07:07:58",updated_at: "2018-04-12 19:29:45")
      @ii30 = @item10.invoice_items.create(quantity: 7, unit_price: 60000, created_at: "2018-04-06 23:02:32",updated_at: "2018-04-14 10:59:43")

      @invoice1.invoice_items << @ii1
      @invoice1.invoice_items << @ii2
      @invoice2.invoice_items << @ii3
      @invoice2.invoice_items << @ii4
      @invoice2.invoice_items << @ii5
      @invoice3.invoice_items << @ii6
      @invoice3.invoice_items << @ii7
      @invoice4.invoice_items << @ii8
      @invoice5.invoice_items << @ii9
      @invoice5.invoice_items << @ii26
      @invoice5.invoice_items << @ii27
      @invoice5.invoice_items << @ii10
      @invoice5.invoice_items << @ii11
      @invoice5.invoice_items << @ii12
      @invoice6.invoice_items << @ii13
      @invoice7.invoice_items << @ii14
      @invoice8.invoice_items << @ii15
      @invoice9.invoice_items << @ii16
      @invoice10.invoice_items << @ii17
      @invoice10.invoice_items << @ii18
      @invoice11.invoice_items << @ii19
      @invoice12.invoice_items << @ii20
      @invoice12.invoice_items << @ii21
      @invoice12.invoice_items << @ii22
      @invoice13.invoice_items << @ii23
      @invoice14.invoice_items << @ii24
      @invoice14.invoice_items << @ii28
      @invoice14.invoice_items << @ii29
      @invoice15.invoice_items << @ii25
      @invoice15.invoice_items << @ii30


      @t1 = @invoice1.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t2 = @invoice2.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "failed")
      @t16 = @invoice2.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t3 = @invoice3.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t4 = @invoice4.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t5 = @invoice5.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "failed")
      @t17 = @invoice5.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t6 = @invoice6.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "failed")
      @t18 = @invoice6.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t7 = @invoice7.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t8 = @invoice8.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t9 = @invoice9.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t10 = @invoice10.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t11 = @invoice11.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t12 = @invoice12.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t13 = @invoice13.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t14 = @invoice14.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
      @t15 = @invoice15.transactions.create(credit_card_number: "11152774365214", credit_card_expiration_date: "never", result: "success")
    end

    describe "self.most_revenue()" do
      it "should return a chosen number of top merchants by revenue" do
        expect(Merchant.most_revenue(5).first.name).to eq("Ondrea Chadburn")
        expect(Merchant.most_revenue(5).first.revenue).to eq(50710.00)
        expect(Merchant.most_revenue(3).to_a.count).to eq(3)
        expect(Merchant.most_revenue(1).first.name).to eq("Ondrea Chadburn")
      end
    end

    describe "self.most_items()" do
      it "should return a chosen number of top merchants by items sold" do
        expect(Merchant.most_items(2).last.name).to eq("Con Chilver")
        expect(Merchant.most_items(2).last.total).to eq(51)
        expect(Merchant.most_items(3).last.total).to eq(33)
        expect(Merchant.most_revenue(3).to_a.count).to eq(3)
      end
    end

    describe "self.date_revenue()" do
      it "should return a list of merchants ordered by their total revenue for a chosen date" do
        expect(Merchant.date_revenue("2018-04-15")).to eq(0.0)
        expect(Merchant.date_revenue("2018-04-15")).to eq(0.0)
        expect(Merchant.date_revenue("15-04-2018")).to eq(0.0)
        expect(Merchant.date_revenue("2018/04/15")).to eq(0.0)
        expect(Merchant.date_revenue("15/04/2018")).to eq(0.0)
      end
    end

    describe "self.favorite_merchant()" do
      it "should return the merchant with the most successful transactions for a chosen customer" do
        expect(Merchant.favorite_merchant(@cust48).name).to eq("Ondrea Chadburn")
        expect(Merchant.favorite_merchant(@cust49).name).to eq("Ondrea Chadburn")
        expect(Merchant.favorite_merchant(@cust50).name).to eq("Raff Faust")
      end
    end

    describe "total_revenue" do
      it "should return total revenue for specific merchant" do
        expect(@merch1.total_revenue/100.0).to eq(50710.00)
      end
    end

    describe "date_revenue()" do
      it "should return the revenue for a mechant for a chosen date" do
        expect(@merch2.date_revenue("2018-04-14")/100.0).to eq(15810)
      end
    end
  end
end
