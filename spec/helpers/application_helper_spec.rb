require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    context "when not passing any page title" do
      it "should return default page title" do
        expect(full_title).to eq(t("page_title"))
      end
    end

    context "when passing page title" do
      it "should return page title with default page title" do
        title = "Home"
        expect(full_title(title)).to eq("#{title} | #{t("page_title")}")
      end
    end
  end

  describe "#flash_message_prefix" do
    context "when alert type is success" do
      it "should return success alert prefix" do
        expect(flash_message_prefix("success")).to eq(t("alert_prefix.success"))
      end
    end

    context "when alert type is info" do
      it "should return info alert prefix" do
        expect(flash_message_prefix("info")).to eq(t("alert_prefix.info"))
      end
    end

    context "when alert type is warning" do
      it "should return warning alert prefix" do
        expect(flash_message_prefix("warning")).to eq(t("alert_prefix.warning"))
      end
    end

    context "when alert type is danger" do
      it "should return danger alert prefix" do
        expect(flash_message_prefix("danger")).to eq(t("alert_prefix.danger"))
      end
    end

    context "when alert type is others" do
      it "should return empty alert prefix" do
        expect(flash_message_prefix("others")).to eq("")
      end
    end
  end
end
