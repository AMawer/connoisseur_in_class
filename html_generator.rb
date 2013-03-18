require "json"
require "open-uri"

class HtmlGenerator
  
  def show
    print_header
    print_footer
  end

  def index
    print_header

    products = retrieve_data

    products.each do |product|
      display_product(product)
      display_image(product)
      display_info(product)
    end

    print_footer
  end

  private

  def display_product(product)
    puts "<h1>#{product['name']}</h1>"
  end

  def display_image(product)
    puts "<img src=#{product['image_thumb_url']}>"
  end

  def display_info(product)
    puts '<ul style="list-style: none;">'
    puts "<li>id:#{product['id']}</li>"
    puts "<li>#{product['producer_name']}</li>"
    puts "<li>#{product['primary_category']}</li>"
    puts "<li>#{product['secondary_category']}</li>"
    puts "<li>#{product['package_unit_volume_in_milliliters']} ml</li>"
    puts "<li>$ #{product['price_in_cents']/100.0}</li>"
    puts "</ul>"
  end

  def print_header
    puts "<html>"
    puts "  <head>"
    puts "    <title>Connoisseur</title>"
    puts "  </head>"
    puts "  <body>"
  end

  def print_footer
    puts "  </body>"
    puts "</html>"
  end

  def retrieve_data
    response = open("http://lcboapi.com/products.json").read
    data = JSON.parse(response)
    return data["result"]
  end

end

@html_generator = HtmlGenerator.new