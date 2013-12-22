# encoding: utf-8

class Model

attr_reader :x,:y,:text_array,:name,:alert,:data
attr_accessor :str_buf

  def initialize
    @text_array = []
    @x = 50
    @y = 50
    @clock = 0
    @str_buf = ""
    @name = ""
    @alert = ""
    @alert_count = 0
    @data = []
  end

  def push_enter
    if(@name == "" && @str_buf != "")
      @name = @str_buf
      unless(connect)
        set_alert("サーバーに接続できません。何回か試してダメだったらお問い合わせください。")
        @name = ""
      end
    end
  end

  def set_alert(str)
    @alert = str
    @alert_count = 120
  end

  def connect
    # ローカルで実験する場合は以下を使用してください
    # @s = TCPSocket.open("localhost", 3002)
    @s = TCPSocket.open("intotheprow.rackbox.net", 40004)
    @s.puts("name")
    @s.puts(@name)
    return @s.gets
  end

  def send_text
    return false unless(@s)
    @s.puts("text")
    @s.puts(@str_buf)
    texts = @s.gets
    @text_array = @s.gets.chomp.gsub("[","").gsub("]","").split(",")
    return @s.gets
  end

  def send_move
    return false unless(@s)
    @s.puts("move")
    @s.puts("#{@x},#{@y}")
    return @s.gets
  end

  def move_by(x,y)
    @x += x*6
    @y += y*6
    @x = 0 if(@x < 0)
    @x = 640 if(@x > 640)
    @y = 0 if(@y < 0)
    @y = TEXT_Y if(@y > TEXT_Y)
    parse_data(send_move)
  end

  def clock
    @clock = @clock%60 + 1
    @alert_count -= 1 if(@alert_count > 0)
    @alert = "" if(@alert_count == 0)
  end

  def parse_data(data)
    p data
    servdata = data.chomp.split(",")
    @data = Array.new(servdata.size/3).map{|m|m=User.new}
    servdata.each_with_index do |pc,i|
      case i%3
      when 0
        @data[i/3].name = pc
      when 1
        @data[i/3].x = pc.to_i
      when 2
        @data[i/3].y = pc.to_i
      end
    end
  end
end

class User
attr_accessor :x,:y,:name
  def initialize
    @name = ""
    @x = 0
    @y = 0
  end
end