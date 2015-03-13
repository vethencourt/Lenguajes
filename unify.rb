
class Atomic
  attr_reader :value

  def initialize(val)
    @value =  val
  end

  def value
    @value
  end

  def to_s
    "Atom #@value"
  end
end


class Variable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def to_s
    "Var #@name"
  end
end


class Functor
  attr_reader 
    :name
    :args

  def initialize(name,args)
    @name = name
    @args = args
  end

  def name
    @name
  end

  def args
    @args
  end

  def to_s
    val = '('
    for elem in @args do
      val = val + elem.to_s + ','
    end
    val[val.length-1] = ')'
    "Functor #@name#{val}"
  end
end


