module ApplicationHelper
  def address_formatter(address)
    address.split(',').first(2).join(',').gsub(',', '')
  end
end
