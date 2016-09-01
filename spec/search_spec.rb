require_relative 'spec_helper'

describe '10k workflow', js: true do
  describe 'basic nav' do
    let(:page) { new_session(:selenium) }
    before do
      page.visit '/'
    end
    it 'works' do
      fill_in 'username', with: ENV['USERNAME']
      click_button 'Continue'
      fill_in 'password', with: ENV['PASSWORD']
      click_button 'Sign in'
      # choose_org
      sleep 1
      page.visit '/reports/summary/budget'
      sleep 1
      find('#filter-2-name').click
      sleep 1
      find('#filter-option-31').click
      expect(page).to have_content 'This Quarter'
      find('#filter-1-name').click
      find('#filter-option-10').click
      find('#filter-option-22').click
      expect(page).to have_content 'Time & Fees: Amounts'
      expect(page).to have_css('#result-cell-0-4', text: '24')
    end
  end
end

def choose_org
  find '.tk-round-module--narrow:nth-of-type(3)' do
    within all('.tk-round-module--narrow').last do
      click 'Nick Tester'
    end
  end
end
