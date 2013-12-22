# -*- coding: utf-8 -*-

module Controller

  def self.input(model)
    str = Input::IME.get_string
    model.str_buf += str if(str != "")

    model.push_enter if(Input::IME.push_keys[0] == 28)
    model.str_buf.chop! if(Input.key_push?(K_BACKSPACE))
    model.move_by(Input.x,Input.y) if(Input.x != 0 || Input.y != 0)
  end

end