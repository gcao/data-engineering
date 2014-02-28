require 'csv'

class RawTransactionsParseService
  def initialize options = {}
    @options = options
  end

  def parse io
    transactions = []

    is_header = true
    CSV.parse(io, @options) do |row|
      if is_header
        is_header = false
        next
      end

      transactions << parse_row(row)
    end

    transactions
  end

  def parse_row row
   customer_name, product_description, product_price, count,
     merchant_address, merchant_name = row

   customer = find_or_create_customer customer_name
   merchant = find_or_create_merchant merchant_name, merchant_address
   product = find_or_create_product merchant, product_description, product_price

   Transaction.new customer: customer, product: product, count: count
  end

  private

  def find_or_create_customer name
    Customer.where(name: name).first or
      Customer.create name: name
  end

  def find_or_create_merchant name, address
    Merchant.where(name: name).first or
      Merchant.create name: name, address: address
  end

  def find_or_create_product merchant, description, price
    Product.where(merchant: merchant, description: description).first or
      Product.create merchant: merchant, description: description, price: price
  end
end

