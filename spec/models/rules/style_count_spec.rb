require "rails_helper"

RSpec.describe ComputedRule::StyleCount do
  describe ".random_feature" do
    it "calls and returns a random single room" do
      expect(Section).to receive(:random_single).and_return(Section.new(10))
      expect(described_class.random_feature).to eq("kitchen")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:room) { instance_double(Room) }
    let(:subject) { described_class.build(house: house, feature: room_name) }
    let(:room_name) { "kitchen" }

    context "when there are no styles" do
      let(:count) { 0 }

      it "randomly builds a rule from the given house with a given feature" do
        expect(house).to receive(:get_room).with(room_name).and_return(room)
        expect(room).to receive(:lower_name).and_return(room_name)
        expect(room).to receive(:count_different_styles).and_return(count)
        expect(subject.text).to eq("The kitchen must have all objects the same style")
      end
    end

    context "when it is all one style" do
      let(:count) { 1 }

      it "randomly builds a rule from the given house with a given feature" do
        expect(house).to receive(:get_room).with(room_name).and_return(room)
        expect(room).to receive(:lower_name).and_return(room_name)
        expect(room).to receive(:count_different_styles).and_return(count)
        expect(subject.text).to eq("The kitchen must have all objects the same style")
      end
    end

    context "when there are 2 styles" do
      let(:count) { 2 }

      it "randomly builds a rule from the given house with a given feature" do
        expect(house).to receive(:get_room).with(room_name).and_return(room)
        expect(room).to receive(:lower_name).and_return(room_name)
        expect(room).to receive(:count_different_styles).and_return(count)
        expect(subject.text).to eq("The kitchen must have 2 different styles of objects")
      end
    end

    context "when there are 3 styles" do
      let(:count) { 3 }

      it "randomly builds a rule from the given house with a given feature" do
        expect(house).to receive(:get_room).with(room_name).and_return(room)
        expect(room).to receive(:lower_name).and_return(room_name)
        expect(room).to receive(:count_different_styles).and_return(count)
        expect(subject.text).to eq("The kitchen must have all three styles of objects")
      end
    end
  end
end
