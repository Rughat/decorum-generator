require "rails_helper"

RSpec.shared_examples "an empty object" do
  describe "class methods" do
    subject { described_class }

    it { is_expected.to be_empty }
    it "has the right short_name" do
      expect(subject.short_name).to eq("empty space")
    end
  end

  describe "instance methods" do
    subject { described_class.new }

    it "has the right description" do
      expect(subject.long_description).to eq("An empty spot")
    end

    it "has nil color and style" do
      expect(subject.color_obj).to be_nil
      expect(subject.style).to be_nil
    end
  end
end

RSpec.describe EmptyCurio do
  it_behaves_like "an empty object"
end

RSpec.describe EmptyLamp do
  it_behaves_like "an empty object"
end

RSpec.describe EmptyWallHanging do
  it_behaves_like "an empty object"
end
