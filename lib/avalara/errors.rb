# encoding: UTF-8

module Avalara
  class Error < StandardError       ; end
  class TimeoutError < Error        ; end
  class NotImplementedError < Error ; end
  class ApiError < Error            ; end
end