require 'rails_helper'

Rspec.describe "Starting a new game" do
  context "on non-mobile" do
    it "can start a game" do
      visit root_path
      click "New Game"

      expect(current_path).to eq new_game_path

      fill_in "Number of players", with: "4"

      click "Start Game"

      # expect page to be on the choose a player page

      expect(page).to have_content "Starting house setup"

      expect(page).to have_button "Join as player 1"
      expect(page).to have_button "Join as player 2"
      expect(page).to have_button "Join as player 3"
      expect(page).to have_button "Join as player 4"

      click "Join as player 1"

      # expect(current_path).to eq player_rules_path

      expect(page).to have_content "Requirements"
    end
  end
end
