require 'uri'
require 'net/http'
require 'openssl'
class PaymentsController < ApplicationController
  def create
    @order = Order.last
    url = URI("https://sandbox.cashfree.com/pg/orders")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["x-client-id"] = '3302226a66bb4599b56ec7dddf222033'
    request["x-client-secret"] = '82215565b064590f5ac9ae3039e786455f249a99'
    request["x-api-version"] = '2022-09-01'
    request["content-type"] = 'application/json'
    body = {
            customer_details: {
              customer_email: "test@test.com", customer_phone: "9098023443",
              customer_id: "121cus"
            },
            order_id: @order.id.to_s, order_amount: 21, order_currency: 'INR',
            order_meta: {
              return_url: 'http://localhost:8080' + "?order_id={order_id}",
              notify_url: 'http://localhost:8080'
            }
          } 
    request.body = body.to_json
    response = http.request(request)

    if response.present? && response.body.present?
      response = JSON.parse(response.body)
      # debugger
      @secret = response["payment_session_id"]
      render :cashfree_form
    else
      redirect_to product_out_of_stock_error_path(:error => 'Payment Failed') and return
    end

    
  end
end