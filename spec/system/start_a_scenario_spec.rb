require "application_system_test_case"

RSpec.describe "creating a new scenario", js: true do
  context "on non-mobile" do
    it "can create a new scenario" do
      visit root_path
      click_on "New Scenario"

      expect(current_path).to eq new_scenario_path

      select "4", from: "Requirements per player"

      select "2", from: "Number of players"
      click_on "Create scenario"

      # expect page to be on the choose a player page
      expect(page).to have_content "Starting Layout"
      within "#starting-layout" do
        within "#room-layout-bathroom" do
          furnishings = all(".furnishing")
          expect(furnishings).to all(match(/A (red|blue|green|yellow) (antique|modern|retro|unusual) (curio|lamp|wall hanging)/)).and have_at_most(3).items
        end

        within "#room-layout-bedroom" do
          furnishings = all(".furnishing")
          expect(furnishings).to all(match(/A (red|blue|green|yellow) (antique|modern|retro|unusual) (curio|lamp|wall hanging)/)).and have_at_most(3).items
        end

        within "#room-layout-living-room" do
          furnishings = all(".furnishing")
          expect(furnishings).to all(match(/A (red|blue|green|yellow) (antique|modern|retro|unusual) (curio|lamp|wall hanging)/)).and have_at_most(3).items
        end

        within "#room-layout-kitchen" do
          furnishings = all(".furnishing")
          expect(furnishings).to all(match(/A (red|blue|green|yellow) (antique|modern|retro|unusual) (curio|lamp|wall hanging)/)).and have_at_most(3).items
        end
      end

      within "#player-specific-data-1" do
        expect(page).to have_button "Show requirements"
        click_on "Show requirements"

        # somehow figure out if the requirements are showing?

        click_on "Hide requirements"
      end

      within "#player-specific-data-2" do
        expect(page).to have_button "Show requirements"
        click_on "Show requirements"

        # somehow figure out if the requirements are showing?

        click_on "Hide requirements"
      end
    end
  end
end
