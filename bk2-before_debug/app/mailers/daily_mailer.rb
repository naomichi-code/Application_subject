class DailyMailer < ApplicationMailer

    default :from => "oreimmoka@gmail.com"

    def daily_mail
        @greeting = "購読ありがとうございます"
        mail( to: "oreimmoka@gmail.com" , :subject => "毎日メールマガジン" )
    end
end
