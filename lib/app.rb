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
end

def get_townhall_names
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

    names_of_town = []
    
    doc.xpath('//tr[2]//p/a').each do |node|
        names_of_town.push(node.text)
    end
    return names_of_town
end

def get_townhall_email
    n = get_townhall_urls.count
    i = 0
    emails = []
    while i < n
        doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com#{get_townhall_urls[i].to_s}"))
        result = doc.xpath('//section[2]/div/table/tbody/tr[4]/td[2]').map do |node|
            emails.push(node.text)
        end
        p emails[i]
        i += 1
    end
    # Data importante : emails.count # => 185

    # Itère dans Names en prenant le même index que prices (car ils sont symetriques)
    # On créé un hash vide
    # On associe name et son index, qui est égal à l'index de l'array prices
    # On itère le hash
    names = get_townhall_names
    result_scrap = names.map.with_index do |name, index|
        new_hash = {}
        new_hash[name] = emails[index]
        new_hash
    end

    return result_scrap
end

### EXERICE DES DEPUTES ###

def get_deputy_urls
    doc = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))

    deputy_urls = []

    doc.xpath('//tr/td[1]/a/@href').each do |node|
        deputy_urls.push(node.text)
    end

    return deputy_urls # => 205 urls
end

### RECUPERATION DES PRENOMS DES DEPUTES ###

def get_deputies_first_names
    names = get_deputy_urls.map {|x| x.delete!("/").gsub('-',' ')}
    # return names #=> count 205 noms
    first_name = names.map do |x|
        x.split.first
    end
    return first_name
end

### RECUPERATION DES NOMS DES DEPUTES

def get_deputies_last_names
    names = get_deputy_urls.map {|x| x.delete!("/").gsub('-',' ')}
    # return names #=> count 205 noms
    last_name = names.map do |x|
        x.rpartition(" ").last
    end
    return last_name
end



def get_deputy_email
    # n = get_deputy_urls.count
    i = 0
    deputy_email = []
    while i < 5
        doc = Nokogiri::HTML(open("https://www.nosdeputes.fr#{get_deputy_urls[i]}"))
        doc.xpath('//ul[2]//li//ul//li[1]/a').each do |node|
            deputy_email.push(node.text)
        end
        p deputy_email[i]
        i += 1
    end
    # return deputy_email # => count ??

    names = get_deputies_first_names
    result_scrap = names.map.with_index do |name, index|
        new_hash = {}
        new_hash[name] = deputy_email[index]
        new_hash
    end

    return result_scrap

end

p get_deputy_email

# p get_deputy_email
# def testing
#     prenoms = ["max", "jiad", "bams"]
#     noms = ["LS", "LP", "AHHa"]
#     mails = ["mia@gmail.com", "jiaad.com","ouech.com"]
    
#     # h = mails.map {|email| {:email => email}}
#     # h2 = 
#     # h3 = noms.map {|nom| {:nom => nom}}
#     # z = { **h, **h2, **h3 }

#     a = Hash[prenoms.map {|key, value| [:first_name, key]}]
#     return a
# end

# p testing

#