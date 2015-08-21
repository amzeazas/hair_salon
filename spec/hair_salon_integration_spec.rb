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

describe('updating info for a stylist', {:type => :feature}) do
  it('allows a user to view the details of a stylist and update any info') do
    visit('/')
    click_link('Click here to view stylists')
    fill_in('first_name', :with => 'Luna')
    fill_in('last_name', :with => 'Lovegood')
    fill_in('phone_number', :with => '2065552222')
    click_button('Add Stylist')
    click_link('Lovegood, Luna')
    fill_in('first_name', :with => '')
    fill_in('last_name', :with => '')
    fill_in('phone_number', :with => '5038675309')
    click_button('Update')
    expect(page).to have_content('Current Stylists')
  end
end

describe('adding a new client', {:type => :feature}) do
  it('allows a user to view a list of clients and a new one') do
    visit('/')
    click_link('Click here to view stylists')
    fill_in('first_name', :with => 'Luna')
    fill_in('last_name', :with => 'Lovegood')
    fill_in('phone_number', :with => '2065552222')
    click_button('Add Stylist')
    visit('/')
    click_link('Click here to view clients')
    fill_in('first_name', :with => 'Ron')
    fill_in('last_name', :with => 'Weasley')
    fill_in('phone_number', :with => '5034567890')
    select('Lovegood, Luna')
    click_button('Add Client')
    expect(page).to have_content('Current Clients')
  end
end

describe('updating info for a client', {:type => :feature}) do
  it('allows a user to view the details of a client and update any info') do
    visit('/')
    click_link('Click here to view stylists')
    fill_in('first_name', :with => 'Luna')
    fill_in('last_name', :with => 'Lovegood')
    fill_in('phone_number', :with => '2065552222')
    click_button('Add Stylist')
    visit('/')
    click_link('Click here to view clients')
    fill_in('first_name', :with => 'Harry')
    fill_in('last_name', :with => 'Potter')
    fill_in('phone_number', :with => '4259876543')
    click_button('Add Client')
    click_link('Potter, Harry')
    fill_in('first_name', :with => '')
    fill_in('last_name', :with => '')
    fill_in('phone_number', :with => '5038675309')
    select('Lovegood, Luna')
    click_button('Update')
    expect(page).to have_content('Current Clients')
  end
end
