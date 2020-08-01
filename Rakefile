# Copyright © 2020 WorldRIZe. All rights reserved.

task :default => [:help]

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

