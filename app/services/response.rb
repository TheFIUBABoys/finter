class Response < SimpleDelegator
  attr_reader :errors

  def initialize(result)
    __setobj__(result)
    @errors = []
  end

  def success?
    errors.size == 0
  end

  def push_error(error)
    @errors.push(error)
  end
end
