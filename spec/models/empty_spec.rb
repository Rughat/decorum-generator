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

    it "has the right icon" do
      expect(subject.icon).to eq("<span class=\"icon-empty-space\"><\/span>")
    end
  end
end

RSpec.describe EmptyCurio do
  subject { described_class.new }
  it_behaves_like "an empty object"

  it "has the right parent icon" do
    expect(subject.parent_icon).to eq("<span class=\"icon-curio\"><\/span>")
  end
end

RSpec.describe EmptyLamp do
  subject { described_class.new }
  it_behaves_like "an empty object"

  it "has the right parent icon" do
    expect(subject.parent_icon).to eq("<span class=\"icon-lamp\"><\/span>")
  end
end

RSpec.describe EmptyWallHanging do
  subject { described_class.new }
  it_behaves_like "an empty object"

  it "has the right parent icon" do
    expect(subject.parent_icon).to eq("<span class=\"icon-wall-hanging\"><\/span>")
  end
end
