# Archivo: unify.rb
# Descripción: 
#    Contiene las clases Term, Atomic, Variable y Functor que presentan
#    los términos de Prolog.
# Autores:
#    F. Miguel Saraiva      Carnet# 09-10794
#    Ricardo Vethencourt    Carnet# 09-10894

class Term
end

class Atomic < Term #Representa los Átomos en Prolog.
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


class Variable < Term #Representa las Variables en Prolog.
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


class Functor < Term #Representa los Functores en Prolog.
  attr_reader 
    :name
    :args

  #Initialize recibe el nombre de functor y un arreglo de argumentos.
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
