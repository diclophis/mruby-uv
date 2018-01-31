#!mruby
begin; require 'mruby-uv'; rescue Exception; end

c = UV::Pipe.new(true)
c.connect('/tmp/mrub-yuv') {|x|
  if x == 0
    c.read_start {|b|
      puts b.to_s
    }
  else
    c.close()
  end
}
UV::run()
