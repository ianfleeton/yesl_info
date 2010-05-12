module AddressesHelper
  def format_address_single_line(a)
    a.address_line_1 + ', ' + a.address_line_2 + ', ' + a.town_city + ', ' + a.county + ', ' + a.postcode
  end
end
