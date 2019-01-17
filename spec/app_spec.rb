require_relative '../lib/app.rb'

describe "scrap coin market should return someting" do 
    it "should return a hash" do 
        expect(scrap_coin_market_cap).to be_truthy
    end
end

describe "scrap get_townhall should return something" do
    it "should return something lol" do
        expect(get_townhall_urls).not_to be_nil
        expect(get_townhall_names).not_to be_nil
    end
end 

describe "scrap get_deputy_email" do 
    it "should return something MDR" do
        expect(get_deputies_first_names).not_to be_nil
        expect(get_deputies_last_names).not_to be_nil
        expect(get_deputy_urls).not_to be_nil
    end
end