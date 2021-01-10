# Copyright © 2020 WorldRIZe. All rights reserved.

task :default => [:setup]

def confirm(q)
  puts "#{q}? (y/n)"
  return STDIN.gets.strip == 'y'
end

desc 'ヘルプ'
task :help do
  sh 'rake -T'
end

task :release do
  sh 'export $(cat ./secrets/.env | grep -v ^# | xargs)'

  # cd 'android' do
  #  sh 'fastlane beta'
  # end

  cd 'ios' do
    sh 'flutter clean'
    sh 'flutter pub get'
    sh 'pod install'
    sh 'fastlane beta'
  end
end

desc 'Run App with Development'
task :dev do
  sh 'flutter run --flavor development -t lib/main_development.dart'
end

desc 'Run App with Staging'
task :stg do
  sh 'flutter run --release --flavor staging -t lib/main_staging.dart'
end

desc 'Run App with Production'
task :prd do
  sh 'flutter run --release --flavor production -t lib/main.dart'
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

desc 'コード生成(watch)'
task :watch do
  puts '[Task watch]'
  sh 'flutter pub run build_runner watch --delete-conflicting-outputs'
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

desc 'ドキュメント'
task :docs do
  excludes = 'dart:async,dart:collection,dart:convert,dart:core,dart:developer,dart:io,dart:isolate,dart:math,dart:typed_data,dart:ui,dart:ffi,dart:html,dart:js,dart:js_util'
  sh "FLUTTER_ROOT=~/flutter dartdoc --output docs/dartdoc --exclude \'#{excludes}\'"

  cd 'functions' do
    sh 'yarn docs'
  end
end

desc 'download assets'
task :download_assets do
   # read ./secrets/.env
   sh 'export $(cat ./secrets/.env | grep -v ^# | xargs); curl gdrive.sh | bash -s $ASSETS_GDRIVE_ID'
   sh 'unzip -qq assets.zip'
   sh 'rm -rf ./assets.zip ./__MACOSX'
end

desc 'upload assets'
task :upload_assets do
  if File.exist?('./assets')
    sh 'zip -r assets.zip assets'
    sh 'sha512sum assets.zip > assets.checksum'
    sh 'echo "please upload assets.zip to google drive!!!"'
  end
end

desc 'setup'
task :setup do
  puts '1. Download Assets'
  Rake::Task[:download_assets].invoke

  puts '2. Install'
  cd 'ios' do
    sh 'pod install'
  end

  sh 'flutter pub get'

  cd 'functions' do
    sh 'yarn'
  end

  puts '3. Generate'
  Rake::Task[:gen].invoke
  Rake::Task[:i10n].invoke
  Rake::Task[:splash].invoke
  Rake::Task[:icon].invoke
end

desc 'cleanとか'
task :clean do
  sh 'flutter clean && flutter pub get && flutter pub cache repair'
end

desc 'update submodule'
task :update_submodule do
  sh 'git submodule update --remote'
end
