require 'watir-webdriver'
require "watir-webdriver/wait"

# Set our User Agent
capabilities = Selenium::WebDriver::Remote::Capabilities.phantomjs("phantomjs.page.settings.userAgent" => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36")


driver = Selenium::WebDriver.for :phantomjs, :desired_capabilities => capabilities
#browser = Watir::Browser.new driver

# Test with GUI Browser
browser = Watir::Browser.new(:firefox)

# Clear Any Cookies
browser.cookies.clear

# Go to the KDP Dashboard
browser.goto 'https://kdp.amazon.com/dashboard'

# Enter your Username
browser.text_field(:name => "email").set(ARGV[0])

# Enter your Password
browser.text_field(:name => "password").set(ARGV[1])

# Click the login button
browser.send_keys :enter

# Save our Cookies
saved_cookies = browser.cookies.to_a
saved_cookies.each do |saved_cookie|
  browser.cookies.add(saved_cookie[:name], saved_cookie[:value], :domain => saved_cookie[:domain], :expires => saved_cookie[:expires], :path => saved_cookie[:path], :secure => saved_cookie[:secure])
end

# Go to the Reports page
browser.link(:text => 'Reports').click

# Wait for Amazon to generate the page
Watir::Wait.until { browser.span(:id, 'updateReportButton').exists? }

# Grab our results
results = browser.html

# Write our results locally
File.open('kdp', File::WRONLY|File::CREAT|File::EXCL) do |file|
    file.write results
end
