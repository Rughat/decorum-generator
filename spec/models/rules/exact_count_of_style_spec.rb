require "rails_helper"

RSpec.describe ComputedRule::ExactCountOfStyle do
  describe ".random_feature" do
    it "calls and returns a random feature" do
      expect(Style).to receive(:random).and_return("modern")
      expect(described_class.random_feature).to eq("modern")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:selected_section) { instance_double(Section) }
    let(:feature) { Style.new("antique") }

    it "randomly builds a rule from the given house with a given feature" do
      expect(Style).to receive(:new).with("antique").and_return(feature)
      expect(sections).to receive(:random).and_return(selected_section)
      expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"></span>".html_safe)
      expect(house).to receive(:count_styles).with(style: "antique", section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: "antique", sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"></span> must contain exactly 3 antique<span class=\"icon-antique\"><\/span> objects")
    end
  end
end
