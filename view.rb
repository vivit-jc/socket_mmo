# -*- coding: utf-8 -*-

module View

  def self.draw_text(model)
    model.text_array.each_with_index do |t,i|
      Window.draw_font(20,TEXT_Y+14*i,text_array,Font12)
    end
    model.data.each do |d|
      Window.draw(d.x,d.y,PC)
      Window.draw_font(d.x,d.y+40,d.name,Font12)
    end
  end

  def self.draw_setup(model)
    Window.draw_font(0,0,"名前を入力してください。エンターでログイン",Font12)
    Window.draw_font(0,20,model.str_buf,Font12)
    Window.draw_font(0,40,model.alert,Font12,{color: [255,0,0]})


  end

end