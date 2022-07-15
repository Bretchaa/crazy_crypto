require 'rubygems'
require 'nokogiri'
require 'open-uri'


home_page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html").read)

def get_townhall_names(home_page)
    townhall_names=[]
    home_page.xpath('//a[@class="lientxt"]').each do |name|
        townhall_names.push(name.text)
     end
    return townhall_names
end


def get_townhall_urls(home_page)
    townhall_urls=[]
    home_page.xpath('//a[@class="lientxt"]').each do |url|
        townhall_urls.push(url["href"])
     end
    return townhall_urls 
end 

def get_townhall_email(home_page)
    townhall_urls = get_townhall_urls(home_page)
    townhall_emails=[]
    townhall_urls.each do |url|
        click_url = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/#{url}").read)
            click_url.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |email|
            townhall_emails.push(email.text)
            end
        end
    return townhall_emails
end


def hash_with_everything(townhall_names,townhall_emails)
    final_hash = Hash[townhall_names.zip(townhall_emails)]
    puts final_hash
end

def main (home_page)
    townhall_names = get_townhall_names(home_page)
    townhall_emails = get_townhall_email(home_page)
    puts hash_with_everything(townhall_names,townhall_emails)
end


perform(home_page)
