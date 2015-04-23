class SchemaValidationError < RuntimeError
  def initialize(msg = 'Schema Validation Failed.')
    super(msg)
  end
end
