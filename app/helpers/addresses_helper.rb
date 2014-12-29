module AddressesHelper
  # Formats an address for display in a single line.
  #
  # ==== Example
  #   a = Address.new(address_line_1: '123 Street', postcode: 'POST CODE')
  #   format_address_single_line(a) # => '123 Street, POST CODE'
  def format_address_single_line(a)
    [a.address_line_1, a.address_line_2, a.town_city, a.county, a.postcode]
      .reject {|e| e.blank?}
      .join(', ')
  end
end
