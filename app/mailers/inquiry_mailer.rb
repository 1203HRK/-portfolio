class InquiryMailer < ApplicationMailer

  default to: ENV['SEND_MAIL']   # 問い合わせメールを管理・確認したいアドレスを書く

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:from => inquiry.email, :subject => 'お問い合わせがありました')
  end
  
  #def userreceived_email(inquiry)
   # @inquiry = inquiry
    #mail(:to => inquiry.email, :subject => 'お問い合わせがありがとうございました')
  #end

end
