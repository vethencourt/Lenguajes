class BinTree
  attr_accessor :value # Valor almacenado en el nodo
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
      puts "Entro en left"
      @left.each(&block)
    end
    unless @right.nil? then
      puts "Entro en right"
      @right.each(&block)
    end
  end
end


class GraphNode
  attr_accessor :value, # Valor alamacenado en el nodo
    :children # Arreglo de sucesores GraphNode
  
  def initialize(v,c)
    @value = v
    @children = c
  end
  
  def each(&block)
    block.call(self)
    @children.each do |elem|
      #puts "Estoy en el hijo #{elem.value}"
      unless elem.nil? then
        elem.each(&block)
      end
    end
    return nil
  end

end


l2 = BinTree.new(9,nil,nil)
r1 = BinTree.new(8,nil,nil)
l1 = BinTree.new(7,l2,nil)
x = BinTree.new(5,l1,r1)
x.each { |y| puts y.value  }


yy1 = GraphNode.new("yy1",[])
yy2 = GraphNode.new("yy2",[])
y1 = GraphNode.new("y1",[yy1,yy2])
y2 = GraphNode.new("y2",[])
y3 = GraphNode.new("y3",[])
y = GraphNode.new("y",[y1,y2,y3])
puts "\n\n\n\n"
puts "Empieza aqui =)"
puts "\n\n\n\n"
y.each { |x| puts x.value }