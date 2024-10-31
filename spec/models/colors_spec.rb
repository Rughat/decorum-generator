require "rails_helper"

RSpec.describe Colors, type: :model do
  describe "#new" do
    it "creates a standard color from the given string" do
      subject = described_class.new("red")
      expect(subject.to_s).to eq("red")
      expect(subject.equal?("red")).to be_truthy
      expect(subject.equal?(described_class.new("red"))).to be_truthy
      expect(subject.equal?("blue")).to be_falsey
      expect(subject.equal?(described_class.new("green"))).to be_falsey
    end

    it "correctly creats a warm color" do
      subject = described_class.new("warm")
      expect(subject.to_s).to eq("warm (red or yellow)")
      expect(subject.equal?("red")).to be_truthy
      expect(subject.equal?(described_class.new("yellow"))).to be_truthy
      expect(subject.equal?("blue")).to be_falsey
      expect(subject.equal?(described_class.new("green"))).to be_falsey
    end

    it "correctly creats a cool color" do
      subject = described_class.new("cool")
      expect(subject.to_s).to eq("cool (blue or green)")
      expect(subject.equal?("red")).to be_falsey
      expect(subject.equal?(described_class.new("yellow"))).to be_falsey
      expect(subject.equal?("blue")).to be_truthy
      expect(subject.equal?(described_class.new("green"))).to be_truthy
    end
  end

  it "can compare a primary color to a descriptor" do
    subject = described_class.new("red")
    cool = described_class.new("cool")
    warm = described_class.new("warm")
    expect(subject.equal?(cool)).to be_falsey
    expect(subject.equal?(warm)).to be_truthy
  end
end
