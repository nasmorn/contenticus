class SlugValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid_slug?(value)
      record.errors.add(attribute, "'#{value}' ist kein valider slug. Großbuchstaben und Leerzeichen sind nicht erlaubt.")
    end
  end

  private

  def valid_slug?(value)
    value =~ /\A[a-z0-9]+(-[a-z0-9]+)*\z/
  end

end
