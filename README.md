#### WHAT
This is a collection of scripts working towards automated checking of sales reports for the following sites:
- Createspace
- DriveThru
- iTunes
- Kindle Direct Publishing (KDP)
- Kobo
- Nook
- Smashwords

#### WHY
I'm working on creating functional scripts for each storefront on my list that can login and download sales data locally. Once I've completed that step for each store I plan on creating a Rails app as an interface.

#### REQUIREMENTS
- Ruby 2.x
- phantomjs
- bundler

#### HOW
- Git clone this repo
  - `git clone https://github.com/chrisanthropic/phantom_ledger.git`
- Install the required Gems
  - `bundle install --binstubs --path=vendor`
- Run the script(s)
  - `bundle exec ruby kdp.rb 'YOUR-KDP-EMAIL/USERNAME' 'YOUR-KDP-PASSWORD'`
  - `bundle exec ruby kobo.rb 'YOUR-KOBO-EMAIL/USERNAME' 'YOUR-KOBO-PASSWORD'`
  - `bundle exec ruby smashwords.rb 'YOUR-SMASHWORDS-EMAIL/USERNAME' 'YOUR-SMASHWORDS-PASSWORD'`
  - etc.

#### ToDo
As of right now the scripts are simply logging in and saving (as .html) the default reports page for each storefront. Once I've got that step done for each storefront I'll start working on DataMapping models to grab only the information we want.

#### COMING SOON?
- Google Play
  - For now, this script doesn't work if 2-factor authorization is enabled on your Google account
  - It also stops short of actually downloading the report due to how Google coded this page
- Gumroad
  - Holding off until later stages so we can use their API directly
