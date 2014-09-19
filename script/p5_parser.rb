require 'open-uri'
require 'nokogiri'

def parse
  results = []
  methods = []
  classes = []
  url = 'http://processing.org/reference/'

  doc = Nokogiri::HTML(open(url))
  doc.css('.content a').each do |item|
    if item.text =~ /^[a-z].+\(\)/
      methods << {'name' => item.text.gsub('(', '').gsub(')', ''), 'url' => item['href']}
    elsif item.text =~ /^[A-Z]/ && !item.text =~ /^[A-Z_]+$/
      classes << {'name' => item.text, 'url' => item['href']}
    end
  end

  methods.each do |method|
    results << {'belong_to' => 'PApplet', 'name' => method['name'], 'sample_code' => Nokogiri::HTML(open(URI.join(url, method['url']))).css('.example pre').text}
  end

  classes.each do |clazz|
    Nokogiri::HTML(open(URI.join(url, clazz['url']))).css('tr').each do |trs|
      if (trs.css('th').text == 'Methods')
        ml = trs.css('a')
        md = Nokogiri::HTML(open(URI.join(url, ml['href'])))
        results << {'belong_to' => clazz.name, 'name' => ml.text, 'sample_code' => md.css('.example > pre').first.text}
      end
    end
  end

  return results
end
