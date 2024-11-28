require "application_system_test_case"

RSpec.describe "rating a scenario", js: true do
  context "with an existing scenario" do
    let(:scenario) { Scenario.build }

    it "can like a scenario" do
      visit root_path

      expect(page).to have_css("#scenario-#{scenario.id}-likes", text: "0")

      visit scenario_path(scenario.id)

      click_on "I like it!"

      visit root_path

      expect(page).to have_css("#scenario-#{scenario.id}-likes", text: "1")
    end

    it "can dislike a scenario" do
      visit root_path
      expect(page).to have_css("#scenario-#{scenario.id}-dislikes", text: "0")

      visit scenario_path(scenario.id)

      click_on "I don't like it"

      visit root_path

      expect(page).to have_css("#scenario-#{scenario.id}-dislikes", text: "1")
    end

    it "can not care about a scenario" do
      visit root_path
      expect(page).to have_css("#scenario-#{scenario.id}-dont-cares", text: "0")
      visit scenario_path(scenario.id)

      click_on "I don't care"

      visit root_path

      expect(page).to have_css("#scenario-#{scenario.id}-dont-cares", text: "1")
    end
  end
end
