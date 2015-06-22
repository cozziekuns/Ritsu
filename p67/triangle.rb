def bottom_up(graph)
  if graph.size == 1
    return graph[0][0]
  else
    new_layer = []
    graph[-2].each_with_index { |value, i|
      new_layer.push(value + [graph[-1][i], graph[-1][i + 1]].max)
    }
    graph[-2] = new_layer
    graph.pop
    return bottom_up(graph)
  end
end

layers = []

File.open("triangle.txt") { |f|
  f.each_line { |line| layers.push(line.split(" ").map { |s| s.to_i }) }
}

p bottom_up(layers)
