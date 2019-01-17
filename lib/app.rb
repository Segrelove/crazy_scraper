require 'nokogiri'
require 'rubygems'
require 'open-uri'
require 'pry'

def scrap_coin_market_cap
    doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
    
    names = []
    doc.xpath('//tr/td[3]').each do |node|
        names.push(node.text)
    end

    prices = []
    doc.xpath('//tr/td[5]/a').each do |node|
        prices.push(node.text)
    end

    # Itère dans Names en prenant le même index que prices (car ils sont symetriques)
    # On créé un hash vide
    # On associe name et son index, qui est égal à l'index de l'array prices
    # On itère le hash
    result_scrap = names.map.with_index do |name, index|
        new_hash = {}
        new_hash[name] = prices[index]
        new_hash
    end

    return result_scrap
end




def get_townhall_urls
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

    names = []

    doc.xpath('//tr[2]//p//a/@href').each do |node|
        names.push(node.text)
    end
    result_url = names.map do |x|
        x[1..-1]
    end
    return result_url
    # return result_url.count
end

# p get_townhall_urls

def get_townhall_email
    n = get_townhall_urls.count
    i = 0
    puts "LET THE SCRAP BEGGGIIIIIIIIIIIIN"
    final_result = []
    while i < n
        doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com#{get_townhall_urls[i].to_s}"))
        emails = []
        doc.xpath('//section[2]/div/table/tbody/tr[4]/td[2]').map do |node|
            emails.push(node.text)
        end
        puts emails
        final_result << emails
        i += 1
    end
    puts "OVER !"
    return final_result
    # return "http://annuaire-des-mairies.com#{get_townhall_urls[0].to_s}"
end

p get_townhall_email