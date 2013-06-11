# encoding: UTF-8

module Avalara
  module Request
    class Address < Avalara::Types::Stash
      property :Line1,      :from => :line_1
      property :Line2,      :from => :line_2
      property :Line3,      :from => :line_3
      property :City,       :from => :city
      property :Region,     :from => :region
      property :Country,    :from => :country
      property :PostalCode, :from => :postal_code
    end
  end
end
