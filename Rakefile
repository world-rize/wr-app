# Copyright © 2020 WorldRIZe. All rights reserved.

task :default => [:help]

desc 'ヘルプ'
task :help do
  sh 'rake -T'
end

desc '全て'
task :all do
  Rake::Task[:help].invoke
end

desc '開発'
task :dev do
  puts '[Task dev]'
  sh 'flutter run --flavor development lib/main_development.dart'
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

desc 'フレーズ更新'
task :phrases do
  puts '[Task phrases]'
  sh 'python scripts/convertor.py'
end

desc 'ボイス更新'
task :voices => [:phrases] do
  puts '[Task voices]'
  sh 'python scripts/rename.py'
end

desc 'スプラッシュ画像更新'
task :splash do
  puts '[Task splash]'
  sh 'flutter pub pub run flutter_native_splash:create'
end

desc 'アイコン更新'
task :icon do
  puts '[Task icon]'
  sh 'flutter packages pub run flutter_launcher_icons:main'
end

desc 'テスト'
task :test do
  puts '[Task test]'
  sh 'flutter test'
  # TODO: server test
end

