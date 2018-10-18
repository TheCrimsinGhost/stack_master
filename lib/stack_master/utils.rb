module StackMaster
  module Utils
    module Initializable
      def initialize(attributes = {})
        self.attributes = attributes
      end

      def attributes=(attributes)
        attributes.each do |k, v|
          instance_variable_set("@#{k}", v)
        end
      end
    end

    extend self

    def change_extension(file_name, extension)
      [
        File.basename(file_name, '.*'),
        extension
      ].join('.')
    end

    def hash_to_aws_parameters(params)
      params.inject([]) do |aws_params, (key, value)|
        aws_params << { parameter_key: key, parameter_value: value }
        aws_params
      end
    end

    def hash_to_aws_tags(tags)
      return [] if tags.nil?
      tags.inject([]) do |aws_tags, (key, value)|
        aws_tags << { key: key, value: value }
        aws_tags
      end
    end

    def underscore_to_hyphen(string)
      string.to_s.gsub('_', '-')
    end

    def underscore_keys_to_hyphen(hash)
      hash.inject({}) do |hash_with_underscore_keys, (key, value)|
        hash_with_underscore_keys[underscore_to_hyphen(key)] = value
        hash_with_underscore_keys
      end
    end
  end
end
