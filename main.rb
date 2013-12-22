# -*- coding: utf-8 -*-

$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
require 'dxruby'
require 'socket'
require 'view'
require 'controller'
require 'model'

Input::IME.enable = true
Font12 = Font.new(12)
model = Model.new
TEXT_Y = 360
PC = Image.load("dot.png")
Window.loop do

  Controller.input(model)
  if(model.name == "")
    View.draw_setup(model)
  else
    View.draw_text(model)
  end
  model.clock

end
