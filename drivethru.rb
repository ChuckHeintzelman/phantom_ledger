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
browser.goto 'http://www.drivethrufiction.com/login.php'

# Wait for the page to load
Watir::Wait.until { browser.a(:text, 'Login/Create Account').exists? }

# Click the login button to open the login form
browser.a(:text => 'Login/Create Account').click

# Enter your Username
browser.text_field(:id => "login_email_address").set(ARGV[0])

# Enter your Password
browser.text_field(:id => "login_password").set(ARGV[1])

# Click the login button
browser.send_keys :enter

# Wait for the page to load
Watir::Wait.until { browser.a(:text, 'Publish').exists? }

# Go to the Reports page
browser.goto 'http://www.drivethrufiction.com/pub_sales_report.php'
browser.wait

# Generate default report
browser.button(:type => 'submit').click

# Wait for the reports to be generated
Watir::Wait.until { browser.tr(:class, 'dtrpgListing-odd').exists? }

# Grab our results
results = browser.html

# Write our results locally
File.open('drivethru', File::WRONLY|File::CREAT|File::EXCL) do |file|
    file.write results
end
