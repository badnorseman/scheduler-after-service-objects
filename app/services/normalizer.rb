class Normalizer
  def initialize(text:)
    @text = text
  end

  def call
    @text.underscore.gsub(/[^0-9a-z\\s]/i, "").singularize
  end
end
