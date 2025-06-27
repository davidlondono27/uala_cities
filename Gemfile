source "https://rubygems.org"
ruby "3.3.8"
gem "fastlane"
gem "xcov"
gem "xcresult"
gem "slather"
gem "danger"
gem "danger-xcode_summary"
gem "danger-slather"
gem "danger-swiftlint"
gem "danger-xcov"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
