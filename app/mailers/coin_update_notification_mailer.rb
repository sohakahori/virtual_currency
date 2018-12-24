class CoinUpdateNotificationMailer < ApplicationMailer

  def notification_success_email
    @coin = Coin.first
    mail(
      from:   "virtual_currency@info.com",
      to: ENV["ADMIN_NOTIFICATION_EMAIL"],
      subject: 'コイン情報の更新'
    )
  end

  def notification_nosuccess_email
    mail(
      from:   "virtual_currency@info.com",
      to: ENV["ADMIN_NOTIFICATION_EMAIL"],
      subject: 'コイン情報の更新の失敗'
    )
  end
end
