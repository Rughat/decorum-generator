require 'application_system_test_case'

RSpec.describe "creating a new game" do
  context "on non-mobile" do
    it "can create a new game" do
      visit root_path
      click_on "New Game"

      expect(current_path).to eq new_game_path

      click_on "Start a 2 player game"

      # expect page to be on the choose a player page
      expect(page).to have_content "Starting Layout"
      within "#starting-layout" do
        within "#room-layout-bathroom" do
          furnishings = all(".furnishing")
          expect(furnishings).to all(match(/A [red|blue|green|yellow] [antique|modern|retro|unusual] [curio|lamp|wall hanging]/)).and have_at_most(3).items
        end

        within "#room-layout-bedroom" do
          furnishings = all(".furnishing")
          expect(furnishings).to all(match(/A [red|blue|green|yellow] [antique|modern|retro|unusual] [curio|lamp|wall hanging]/)).and have_at_most(3).items
        end

        within "#room-layout-living-room" do
          furnishings = all(".furnishing")
          expect(furnishings).to all(match(/A [red|blue|green|yellow] [antique|modern|retro|unusual] [curio|lamp|wall hanging]/)).and have_at_most(3).items
        end

        within "#room-layout-kitchen" do
          furnishings = all(".furnishing")
          expect(furnishings).to all(match(/A [red|blue|green|yellow] [antique|modern|retro|unusual] [curio|lamp|wall hanging]/)).and have_at_most(3).items
        end
      end

      expect(page).to have_button "Show requirements for player 1"
      expect(page).to have_button "Show requirements for player 2"

      click_on "Show requirements for player 1"

      # expect(current_path).to eq player_rules_path

      expect(page).to have_content "Requirements"

      # expect(page).to have_content some list of requirements for player 1

      click_on "Close"

      click_on "Show requirements for player 2"

      # expect(current_path).to eq player_rules_path

      expect(page).to have_content "Requirements"

      # expect(page).to have_content some list of requirements for player 1
    end
  end
end
