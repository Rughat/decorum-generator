require "rails_helper"

RSpec.describe Style do
  describe ".random" do
    let(:randomizer) { class_double(Kernel) }
    subject { described_class.random(randomizer: randomizer) }

    context "when random is 0" do
      it "randomly selects modern" do
        expect(randomizer).to receive(:rand).with(4).and_return(0)
        expect(subject.to_s).to eq("modern")
      end
    end

    context "when random is 1" do
      it "randomly selects antique" do
        expect(randomizer).to receive(:rand).with(4).and_return(1)
        expect(subject.style).to eq("antique")
      end
    end

    context "when random is 2" do
      it "randomly selects retro" do
        expect(randomizer).to receive(:rand).with(4).and_return(2)
        expect(subject.to_s).to eq("retro")
      end
    end

    context "when random is 3" do
      it "randomly selects unusual" do
        expect(randomizer).to receive(:rand).with(4).and_return(3)
        expect(subject.style).to eq("unusual")
      end
    end
  end
end
