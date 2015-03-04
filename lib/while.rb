class While < Struct.new(:condition, :body)
  def to_s
    "while (#{condition}) { #{body} }"
  end

  def inspet
    "<<#{self}>>"
  end

  def reducible?
    true
  end

  def reduce(environment)
    [IF.new(condition, Sequence.new(body, self), DoNothing.new), environment]
  end

  def evaluate(environment)
    case condition.evaluate(environment)
    when Boolean.new(true)
      evaluate(body.evaluate(environment))
    when Boolean.new(false)
      environment
    end
  end
end
