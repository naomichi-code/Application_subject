class ThanksMailer < ApplicationMailer
    default :from => "oreimmoka@gmail.com"

    def send_signup_email(user)
        @greeting = "Hi"
        mail( to: user.email , :subject => "会員登録が完了しました。" )
    end

end