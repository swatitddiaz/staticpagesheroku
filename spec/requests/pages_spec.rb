#require 'spec_helper'
#
#describe "Pages" do
#  describe "GET /pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get pages_index_path
#      response.status.should be(200)
#    end
#  end
#end

require 'spec_helper'

RSpec.configure do |config|
  config.include Capybara::DSL
end

describe "Pages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	
	describe "GET /pages" do
		describe "Home page" do

		    it "should have the content 'home'" do
		      visit '/pages/home'
		      expect(page).to have_content('Home')
		    end

		    it "should have the right title" do
				visit '/pages/home'
				expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
			end
		end

		describe "Help page" do

		    it "should have the content 'help'" do
		      visit '/pages/help'
		      expect(page).to have_content('Help')
		    end

		    it "should have the right title" do
				visit '/pages/help'
				expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
			end
		end

		describe "About page" do

		    it "should have the content 'About Us'" do
		        visit '/pages/about'
		        expect(page).to have_content('About Us')
		    end

		    it "should have the title 'About Us'" do
		        visit '/pages/about'
		        expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
		    end
		end

		describe "Contact page" do

		    it "should have the content 'Contact'" do
		      visit '/pages/contact'
		      expect(page).to have_content('Contact')
		    end

		    it "should have the title 'Contact'" do
		      visit '/pages/contact'
		      expect(page).to have_title("#{base_title} | Contact")
		    end
		end
    
    subject { page }

    describe "profile page" do
      let(:user) { FactoryGirl.create(:user) }
      before { visit user_path(user) }

      it { should have_content(user.name) }
      it { should have_title(user.name) }
    end

    describe "signup page" do
      before { visit signup_path }

      it { should have_content('Sign up') }
      it { should have_title(full_title('Sign up')) }
    end

	end

end


