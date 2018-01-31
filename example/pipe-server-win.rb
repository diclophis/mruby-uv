#!mruby
begin; require 'mruby-uv'; rescue Exception; end

s = UV::Pipe.new(false)
s.bind('\\\\.\\pipe\\mruby-uv')
s.listen(1) {|x|
  return if x != 0
  c = s.accept()
  puts "connected"
  t = UV::Timer.new()
  t.start(1000, 1000) {|x|
    puts "helloworld\n"
    begin
      c.write "helloworld\r\n"
    rescue UVError
      c.close()
      t.stop()
      t = nil
    end
  }
}
UV::run()
