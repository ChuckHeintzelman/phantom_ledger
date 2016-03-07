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
browser.goto 'https://play.google.com/books/publish/redirect'

# Enter your Username
browser.text_field(:id => "Email").set(ARGV[0])

# Click the login button
browser.send_keys :enter

# Wait for the page to load
Watir::Wait.until { browser.text_field(:id => "Passwd").exists? }

# Enter your Password
browser.text_field(:id => "Passwd").set(ARGV[1])

# Click the login button
browser.send_keys :enter

# Go to the Reports page
browser.span(:text => 'Analytics & Reports').click

# Wait for the page to load
Watir::Wait.until { browser.div(:text, 'Export Complete Report').exists? }

# Click on 'All Time'
browser.div(:xpath ,'//div[@role="radio"]').click
browser.wait

# Generate default report
browser.div(:text => 'Export Complete Report').click
browser.wait
