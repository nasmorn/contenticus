# frozen_string_literal: true

module Contenticus
  class Slug < ActiveRecord::Base
    self.table_name = "contenticus_slugs"
    has_ancestry

    # Relationships
    belongs_to :sluggable, polymorphic: true

    # Callbacks
    before_validation :escape_slug,
                      :assign_full_path,
                      :assign_empty_slug

    # Validations
    validates_uniqueness_of :full_path, scope: :domain
    validates_presence_of :label

    validates :slug,
              presence:   true,
              uniqueness: { scope: :ancestry },
              unless:     lambda { |p| self.root? },
              slug:       true

    def self.for_select
      all
    end

    def assign_full_path
      self.full_path = if parent
                         [CGI.escape(parent.full_path).gsub("%2F", "/"), slug]
                           .join("/")
                           .squeeze("/")
                       else
                         "/"
                       end
    end

    def assign_empty_slug
      self.slug = "" if slug.nil?
    end

    def escape_slug
      self.slug = CGI.escape(slug) unless slug.nil?
    end
  end
end
