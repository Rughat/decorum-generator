class House < ApplicationRecord
  has_one :game
  has_many :rooms

  def self.generate(player_count: 2)
    house = self.create
    house.rooms.append(Room.generate(room_type: "living_room"))
    house.rooms.append(Room.generate(room_type: "kitchen"))
    house.rooms.append(Room.generate(room_type: "bathroom"))
    house.rooms.append(Room.generate(room_type: "bedroom"))
    house.save
    house
  end
end
