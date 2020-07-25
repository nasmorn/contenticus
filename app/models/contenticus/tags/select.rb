# frozen_string_literal: true

module Contenticus
  module Tags
    class Select < Base
      attr_reader :scope

      def initialize(block, key:, name: nil, parent: nil, comment: nil, model:, label: "contenticus_label", scope: "all")
        super block, key: key, name: name, comment: comment, parent: parent
        @model = model.classify.constantize
        @scope = @model.send(scope)
        @label = label
      end

      def options
        @scope.map do |record|
          [record.send(@label), record.id]
        end
      end

      def object
        return nil if value.blank?

        @model.find(value)
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end
  end
end
