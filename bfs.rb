# Archivo: bfs.rb
# Descripción: 
#    Contiene las clases BinTree, GraphNode, LCR y el módulo BFS.
#    Las primeras dos clases tienen implementada la función each con un 
#    recorrido BFS.
# Autores:
#    F. Miguel Saraiva      Carnet# 09-10794
#    Ricardo Vethencourt    Carnet# 09-10894

module BFS

  # Retorna el primer elemento encontrado que cumpla con 'predicate',
  # empezando desde 'start'.
  def find(start,predicate)
    start.each { |elem| 
      if predicate.call(elem) then
        return elem
      end
    }
    nil
  end

  # Retorna un arreglo de elementos desde 'start' hasta el primer elemento
  # encontrado que cumpla con 'predicate'.
  def path(start,predicate)
    array = Array.new
    start.each { |elem|
      array.push(elem)
      if predicate.call(elem)
        return array
      end
    }
    nil
  end

  # Retorna un arreglo de elementos con todo el espacio de búsqueda empezando
  # desde 'start'. Si 'action' está definido, ejecuta su código a cada elemento
  # antes de anexarlo al arreglo
  def walk(start,action = nil)
    array = Array.new
    if action then
      start.each { |elem| 
        action.call(elem)
        array.push(elem)
      }
    else
      start.each { |elem|
        array.push(elem)
      }
    end
    return array
  end
end


class BinTree
  include BFS
  attr_accessor :value # Valor almacenado en el nodo
                :left # BinTree izquierdo
                :right # BinTree derecho

  def initialize(v,l,r)
    @value = v
    @left = l
    @right = r
  end

  def left
    @left
  end

  def right
    @right
  end

  def each(&block) # Implementación estilo BFS
    nodes = Array.new
    nodes.push(self)
    while nodes.any?
      elem = nodes.shift
      block.call(elem)
      nodes.push(elem.left) if elem.left
      nodes.push(elem.right) if elem.right
    end
  end
end

class GraphNode
  include BFS
  attr_accessor
    :value # Valor alamacenado en el nodo
    :children # Arreglo de sucesores GraphNode
  
  def initialize(v, c)
    @value = v
    @children = c
  end

  def value
    @value
  end

  def children
    @children
  end
  
  def each(&block)  # Implementación estilo BFS
    nodes = Array.new()
    nodes.push(self)
    begin
      elem = nodes.shift
      block.call(elem)
      for x in elem.children do
        nodes.push(x)
      end
    end while nodes.any?
  end
end


class LCR
    attr_reader :value
    #posBarco puede ser solo :izq o :der
    #izq y der son arreglos de symbol,
    #subconjuntos disjuntos de {:lobo, :cabra, :col} 
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
