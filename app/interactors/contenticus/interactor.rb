module Contenticus
  class Interactor

    def self.call(options)
      self.new(options).call
    end

  end
end