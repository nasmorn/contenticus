class JsonSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    if hash.kind_of?(Hash)
      hash.with_indifferent_access
    elsif hash.kind_of?(String)
      JSON.parse(hash).with_indifferent_access
    elsif hash.nil?
     {}.with_indifferent_access
    else
      raise hash.inspect
    end
  end
end
