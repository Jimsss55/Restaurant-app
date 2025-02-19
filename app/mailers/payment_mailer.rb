class PaymentMailer < ApplicationMailer
  default from: '02210201.cst@rub.edu.bt'

  def payment_detail_email(customer, payment_detail)
    @customer = customer
    @payment_detail = payment_detail

    mail(to: @payment_detail.email, subject: "Your Payment Details")
  end
end
