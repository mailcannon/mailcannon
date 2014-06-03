require "spec_helper"

describe MailCannon::EnvelopeBagReduceJob do
  describe "perform" do

    let(:bag_1) { create(:filled_envelope_bag) }
    let(:bag_2) { create(:filled_envelope_bag) }

    it "calls the reduce trigger for each envelope" do
      Sidekiq::Testing.inline! do
        expect(MailCannon::EnvelopeBag).to receive(:reduce_statistics_for_envelope_bag).with(bag_2.id.to_s)
        expect(MailCannon::EnvelopeBag).to receive(:reduce_statistics_for_envelope_bag).with(bag_1.id.to_s)
        MailCannon::EnvelopeBagReduceJob.perform_async([bag_2.id, bag_1.id])
      end
    end
  end
end
