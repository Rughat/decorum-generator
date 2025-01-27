require "rails_helper"

RSpec.describe ComputedRule::RelativeCountOfFurnishing do
  describe ".random_feature" do
    it "calls and returns a random feature" do
      expect(Furnishing).to receive(:random).and_return(WallHanging)
      expect(described_class.random_feature).to eq("WallHanging")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:selected_section) { instance_double(Section) }
    let(:opposite_section) { instance_double(Section) }

    context "when the feature is a lamp" do
      let(:feature) { Lamp.new }

      it "randomly builds a rule from the given house when there are more in the first section" do
        expect(Lamp).to receive(:new).and_return(feature)
        expect(sections).to receive(:random_multiroom_opposable).and_return(selected_section)
        expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"><\/span>")
        expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
        expect(opposite_section).to receive(:display).and_return("bottom floor<span class=\"icon-bottom-floor\"><\/span>")
        expect(house).to receive(:count_furnishings).with(furnishing: feature.short_name, section: selected_section).and_return(3)
        expect(house).to receive(:count_furnishings).with(furnishing: feature.short_name, section: opposite_section).and_return(2)
        subject = described_class.build(house: house, feature: feature.class.to_s, sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"><\/span> must contain more lamps<span class=\"icon-lamp\"></span> than the bottom floor<span class=\"icon-bottom-floor\"><\/span>")
      end

      it "randomly builds a rule from the given house when there are fewer in the first section" do
        expect(Lamp).to receive(:new).and_return(feature)
        expect(sections).to receive(:random_multiroom_opposable).and_return(selected_section)
        expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"><\/span>")
        expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
        expect(opposite_section).to receive(:display).and_return("bottom floor<span class=\"icon-bottom-floor\"><\/span>")
        expect(house).to receive(:count_furnishings).with(furnishing: feature.short_name, section: selected_section).and_return(1)
        expect(house).to receive(:count_furnishings).with(furnishing: feature.short_name, section: opposite_section).and_return(3)
        subject = described_class.build(house: house, feature: feature.class.to_s, sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"><\/span> must contain fewer lamps<span class=\"icon-lamp\"></span> than the bottom floor<span class=\"icon-bottom-floor\"><\/span>")
      end

      it "randomly builds a rule from the given house when there are an equal amount in both sections" do
        expect(Lamp).to receive(:new).and_return(feature)
        expect(sections).to receive(:random_multiroom_opposable).and_return(selected_section)
        expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"><\/span>")
        expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
        expect(opposite_section).to receive(:display).and_return("bottom floor<span class=\"icon-bottom-floor\"><\/span>")
        expect(house).to receive(:count_furnishings).with(furnishing: feature.short_name, section: selected_section).and_return(3)
        expect(house).to receive(:count_furnishings).with(furnishing: feature.short_name, section: opposite_section).and_return(3)
        subject = described_class.build(house: house, feature: feature.class.to_s, sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"><\/span> must contain an equal amount of lamps<span class=\"icon-lamp\"></span> as the bottom floor<span class=\"icon-bottom-floor\"><\/span>")
      end
    end
  end
end
