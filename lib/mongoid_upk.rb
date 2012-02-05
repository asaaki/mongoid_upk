# encoding: utf-8
require "uuid"

module Mongoid
  module UPK

    class MissingDependency < StandardError
    end

    extend ActiveSupport::Concern

    included do
      unless self.ancestors.include?(Mongoid::Document)
        raise MissingDependency, "You must include Mongoid::Document BEFORE Mongoid::UPK"
      end
      uuid_pk
    end

    module ClassMethods

      # UUID compact (32 digits)
      def uuid_pk
        key :_id do |origin_bson_id|
          uuid = UUID.new
          "#{uuid.generate(:compact)}"
        end
      end

      # UUID with hyphens (36 digits)
      def pretty_uuid_pk
        key :_id do |origin_bson_id|
          uuid = UUID.new
          "#{uuid.generate}"
        end
      end

      # BSON::ObjectId + UUID
      def bson_uuid_pk
        key :_id do |origin_bson_id|
          uuid = UUID.new
          "#{origin_bson_id}-#{uuid.generate(:compact)}"
        end
      end

    end

  end
end
