namespace :db do
  desc "コイン(coins)のマスターデータをインサート"
  task :coins_create => :environment do
    begin
      CreateAndUpdateCoinsService.new.create
    rescue => e
      puts "処理失敗"
      p e.message
      next
    end
    puts "コインの登録が完了しました"
    next
  end

  desc "コイン(coins)のマスターデータをアップデート"
  task :coins_update => :environment do
    begin
      CreateAndUpdateCoinsService.new.update
    rescue => e
      CoinUpdateNotificationMailer.notification_nosuccess_email().deliver
      puts "処理失敗"
      p e.message
      next
    end
    CoinUpdateNotificationMailer.notification_success_email().deliver
    puts "コインの更新が完了しました"
    next
  end
end
