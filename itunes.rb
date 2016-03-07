require 'watir-webdriver'
require "watir-webdriver/wait"
require "fileutils"

# Set our User Agent
capabilities = Selenium::WebDriver::Remote::Capabilities.phantomjs("phantomjs.page.settings.userAgent" => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36")

driver = Selenium::WebDriver.for :phantomjs, :desired_capabilities => capabilities
#browser = Watir::Browser.new driver

# Test with GUI Browser
browser = Watir::Browser.new(:firefox)

# Go to the login page
browser.goto 'https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa'

# Wait for the page to be generated
Watir::Wait.until { browser.iframe(:id, 'authFrame').exists? }

# Enter your Username
browser.iframe(:id, 'authFrame').text_field(:id => "appleId").set(ARGV[0])

# Enter your Password
browser.iframe(:id, 'authFrame').text_field(:id => "pwd").set(ARGV[1])

# Click the login button
browser.send_keys :enter

# Wait for the page to be generated
Watir::Wait.until { browser.ul(:id, 'main-nav').exists? }

# Go to the Reports page
browser.goto 'https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/da/jumpTo?page=salesReports'

# Wait for the page to be generated
Watir::Wait.until { browser.div(:id, 'measureFilter').exists? }

# Grab our results
results = browser.html

# Write our results locally
File.open('itunes', File::WRONLY|File::CREAT|File::EXCL) do |file|
    file.write results
end
