require 'rubygems'
require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/").read)


def array_of_crypto_names(page)
    crypto_names =[]
    page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[2]/div/a[1]').each do |name|
         crypto_names.push(name.text)
      end
    return crypto_names
end

def array_of_crypto_prices(page)
    crypto_prices =[]
    page.xpath('//a[@class="cmc-link"]/span').each do |price|
         crypto_prices.push(price.text)
    end
    crypto_prices.delete("Cryptocurrencies")
    crypto_prices.delete("Community")
    crypto_prices = crypto_prices.map{ |prices| prices.tr('$','').tr(',','')}
    crypto_prices = crypto_prices.map{ |prices| prices.to_f}
    return crypto_prices
end

def hash_with_everything(crypto_prices,crypto_names)
    final_hash = Hash[crypto_names.zip(crypto_prices)]
    puts final_hash
end

def perform(page)
    crypto_names = array_of_crypto_names(page)
    crypto_prices = array_of_crypto_prices(page)
    hash_with_everything(crypto_prices,crypto_names)
end

perform(page)


