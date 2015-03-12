class BinTree
  attr_accessor
    :value # Valor almacenado en el nodo
    :left # BinTree izquierdo
    :right # BinTree derecho

  def initialize(v,l,r)
    @value = v
    @left = l
    @right = r
  end

  def each(&block)
    block.call(self)
    unless @left.nil? then
      @left.each(&block)
    end
    unless @right.nil? then
      @right.each(&block)
    end
  end

end


class GraphNode
  attr_accessor
    :value # Valor alamacenado en el nodo
    :children # Arreglo de sucesores GraphNode
  
  def initialize(v, c)
    @value = v
    @children = c
  end
  
  def each(&block)
    block.call(self)
    @children.each do |elem|
      unless elem.nil? then
        elem.each(&block)
      end
    end
    return nil
  end

end

class LCR
    attr_reader :value
    #posBarco puede ser solo :izq o :der
    #izq y der son arreglos de symbol,
    #subconjuntos disconjuntos de {:lobo, :cabra, :col} 
    def initialize(posBarco, izq, der)
        val = Hash.new
        val['where'] = posBarco
        val['left'] = izq
        val['right'] = der
        if esValido(val)  then
            @value = val
        else
            raise 'Estado invalido'
        end
    end
    
    def each(p)

    end

    def solve

    end
   
    def esValido(edo)
        not (edo.value?([:lobo, :cabra]) or edo.value?([:cabra, :lobo]) or \
            edo.value?([:lobo, :cabra]) or edo.value?([:cabra, :col]) or \
            edo.value?([:col, :cabra]))
    end
        
end
