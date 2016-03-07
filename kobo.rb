require 'watir-webdriver'
require "watir-webdriver/wait"
require "fileutils"

# Set our User Agent
capabilities = Selenium::WebDriver::Remote::Capabilities.phantomjs("phantomjs.page.settings.userAgent" => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36")

driver = Selenium::WebDriver.for :phantomjs, :desired_capabilities => capabilities
browser = Watir::Browser.new driver

# Test with GUI Browser
#browser = Watir::Browser.new(:firefox)

# Go to the login page
browser.goto 'https://writinglife.kobobooks.com/dashboard'

# Enter your Username
browser.text_field(:id => "EditModel_Email").set(ARGV[0])

# Enter your Password
browser.text_field(:id => "EditModel_Password").set(ARGV[1])

# Click the login button
browser.button(:type => 'submit').click
browser.wait

# Grab our results
results = browser.html

# Write our results locally
File.open('kobo', File::WRONLY|File::CREAT|File::EXCL) do |file|
    file.write results
end
