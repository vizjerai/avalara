# encoding: UTF-8

module Avalara
  module Response
    autoload :AddressValidation, 'avalara/response/address_validation'
    autoload :CancelTax,         'avalara/response/cancel_tax'
    autoload :CancelTaxResult,   'avalara/response/cancel_tax_result'
    autoload :Invoice,           'avalara/response/invoice'
    autoload :Message,           'avalara/response/message'
    autoload :TaxLine,           'avalara/response/tax_line'
    autoload :TaxDetail,         'avalara/response/tax_detail'
    autoload :TaxAddress,        'avalara/response/tax_address'
    autoload :Tax,               'avalara/response/tax'
    autoload :ValidationAddress, 'avalara/response/validation_address'
  end
end
