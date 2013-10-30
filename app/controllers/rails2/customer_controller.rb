# -*- coding: utf-8 -*-
require 'aws/ses'
class CustomerController < ApplicationController
  ssl_required :index,:send_message
  def index
    @customer_message = CustomerMessage.new(params[:customer_message])
  end
  def send_message
    @customer_message = CustomerMessage.new(params[:customer_message])
    @customer_message.received_time = Time.now
    @customer_message.ip_addr = request.remote_addr
    @customer_message.reply = false if @customer_message.reply == 0
    if @customer_message.save
	    cid = @customer_message.id
	    @customer_message = CustomerMessage.find(cid)
      ses_send(@customer_message) if @customer_message
      #CustomerMail.deliver_customer_message(@customer_message)
      #CustomerMail.deliver_customer_message_inspected(@customer_message)
      flash[:notice] = "メッセージを送信いたしました。ご意見をいただきまして、ありがとうございました。"
      redirect_to :action => "index"
    else
      render :template => "customer/index"
    end
  end

  def ses_send(m)
    ses = AWS::SES::Base.new(
      :access_key_id => 'AKIAI2Q5IAVIWTLA2SKA',
      :secret_access_key => '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')

    ses.send_email(
      :to        => 'info@yamaokaya.com',
      :source    => 'info@yamaokaya.com',
      :subject   => m.subject_raw,
      :text_body => m.body_raw
    )

    ses.send_email(
      :to        => 'customer_message@yamaokaya.co.jp',
      :source    => 'info@yamaokaya.com',
      :subject   => m.subject_inspected,
      :text_body => m.body_inspected
    )
  end
end
