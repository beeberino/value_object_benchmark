require 'benchmark'

class PointClass
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end
end

point_struct = Struct.new(:x, :y)
point_hash = ->(x,y) { Hash[x: x, y: y] }

n = 1_000_000
Benchmark.bm do |x|
  x.report('class: ') { n.times { PointClass.new(Random.new.rand(100), Random.new.rand(100)) } }
  x.report('struct: ') { n.times { point_struct.new(Random.new.rand(100), Random.new.rand(100)) } }
  x.report('hash: ') { n.times { point_hash.call(Random.new.rand(100), Random.new.rand(100)) } }
end
