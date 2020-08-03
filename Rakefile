# Copyright © 2020 WorldRIZe. All rights reserved.

task :default => [:help]

def confirm(q)
  puts "#{q}? (y/n)"
  return STDIN.gets.strip == 'y'
end

desc 'ヘルプ'
task :help do
  sh 'rake -T'
end

desc 'Run App with Development'
task :dev do
  sh 'flutter run --flavor development -t lib/main_development.dart'
end

desc 'Run App with Staging'
task :stg do
  sh 'flutter run --flavor staging -t lib/main_staging.dart'
end

desc 'Run App with Production'
task :prd do
  sh 'flutter run --flavor production -t lib/main_production.dart'
end

desc 'open Xcode Workspace'
task :xc do
  sh 'open ios/Runner.xcworkspace'
end

desc 'コード生成'
task :gen do
  puts '[Task gen]'
  sh 'flutter pub run build_runner build --delete-conflicting-outputs'
end

desc 'i10n生成'
task :i10n do
  puts '[Task i10n]'
  sh 'sh scripts/i10n.sh'
end

desc 'スプラッシュ画像更新'
task :splash do
  puts '[Task splash]'
  sh 'flutter pub run flutter_native_splash:create'
end

desc 'アイコン更新'
task :icon do
  puts '[Task icon]'
  sh 'flutter pub run flutter_launcher_icons:main'
end

desc 'アセットダウンロード'
task :assets => ['./assets/'] do
  puts 'assets placed'
end

desc 'テスト'
task :test do
  puts '[Task test]'
  # flutter unit test
  sh 'flutter test --coverage'

  # TODO: flutter driver test
  # TODO: codecov
  
  # clound functions test
  cd 'functions' do
    sh 'yarn test'
  end
end

# credentials
file './assets/' do
  abort if !confirm('Download \'./assets/\'')
  sh 'curl gdrive.sh | bash -s 1V_VL81ddzQbr3dtbEBpGOx_RX0uz5CEG'
  sh 'unzip -qq assets.zip'
  sh 'rm -rf ./assets.zip ./__MACOSX'
end

file './.env/.env' do
  abort if !confirm('Download \'./.env/.env\'')
end

# firebase server credential
file './.env/credential.json' do
  # TODO download secrets
  puts 'download from Firebase console'
end

# firebase web client credential
file './.env/worldrize-9248e-d680634159a0.json' do
  # TODO download secrets
  puts 'download from Firebase console'
end

# firebase android credential
file './android/app/google-services.json' do
  # TODO download secrets
  puts 'download from Firebase console'
end

# firebase ios credential
file './ios/Runner/GoogleService-Info.plist' do
  puts 'download from Firebase console'
end

desc 'setup'
task :setup => [
  './assets/', 
  './.env/.env',
  './.env/credential.json',
  './.env/worldrize-9248e-d680634159a0.json',
  './android/app/google-services.json',
  './ios/Runner/GoogleService-Info.plist',
] do
  Rake::Task[:gen].invoke
  Rake::Task[:i10n].invoke
  Rake::Task[:splash].invoke
  Rake::Task[:icon].invoke
end