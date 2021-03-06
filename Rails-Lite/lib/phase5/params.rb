require 'uri'
require 'byebug'

module Phase5
  class Params
    attr_reader :params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params

      if req.query_string
        parse_www_encoded_form(req.query_string)
      end

      if req.body
        parse_www_encoded_form(req.body)
      end

    end

    def [](key)
      key = key.to_s
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)

      key_value_arrays = URI::decode_www_form(www_encoded_form)

      key_value_arrays.each do |arr|
        keys = parse_key(arr[0])
        value = arr[1]
        nested_hash(@params, keys, value)
      end
    end

    def nested_hash(scope, keys, value)
      if keys.count == 1
        scope[keys.first] = value
        scope
      else
        key = keys.shift
        scope[key] ||= {}
        nested_hash(scope[key],keys,value)
      end
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
