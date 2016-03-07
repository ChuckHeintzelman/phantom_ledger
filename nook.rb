require 'watir-webdriver'
require "watir-webdriver/wait"
require "fileutils"

# Set our User Agent
capabilities = Selenium::WebDriver::Remote::Capabilities.phantomjs("phantomjs.page.settings.userAgent" => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36")

driver = Selenium::WebDriver.for :phantomjs, :desired_capabilities => capabilities
browser = Watir::Browser.new driver

# Test with GUI Browser
#browser = Watir::Browser.new(:chrome)

# Go to the login page
browser.goto 'https://www.nookpress.com/login'
browser.link(:id => "clickclick").click

# Enter your Username
browser.text_field(:id => "email").set(ARGV[0])

# Enter your Password
browser.text_field(:id => "password").set(ARGV[1])

# Click the login button
browser.send_keys :enter
browser.wait

# Go to the Reports page
browser.goto 'https://www.nookpress.com/sales'

# Wait for the reports to be generated
Watir::Wait.until { browser.div(:id, 'highcharts-0').exists? }

# Grab our results
results = browser.html

# Write our results locally
File.open('nook', File::WRONLY|File::CREAT|File::EXCL) do |file|
    file.write results
end
