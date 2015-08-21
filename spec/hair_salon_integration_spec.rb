require('capybara/rspec')
require('launchy')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new stylist', {:type => :feature}) do
  it('allows a user to view a list of stylists and a new one') do
    visit('/')
    click_link('Click here to view stylists')
    fill_in('first_name', :with => 'Luna')
    fill_in('last_name', :with => 'Lovegood')
    fill_in('phone_number', :with => '2065552222')
    click_button('Add Stylist')
    expect(page).to have_content('Current Stylists')
  end
end
