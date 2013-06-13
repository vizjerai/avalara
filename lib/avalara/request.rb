# encoding: UTF-8

module Avalara
  module Request
    autoload :Address,        'avalara/request/address'
    autoload :CancelTax,      'avalara/request/cancel_tax'
    autoload :DetailLevel,    'avalara/request/detail_level'
    autoload :Invoice,        'avalara/request/invoice'
    autoload :InvoiceAddress, 'avalara/request/invoice_address'
    autoload :Line,           'avalara/request/line'
    autoload :Message,        'avalara/request/message'
  end
end
