require_relative '../lib/app.rb'

describe "should return someting" do 
    it "should return a hash" do 
        expect(scrap_coin_market_cap).to be_truthy
    end
end