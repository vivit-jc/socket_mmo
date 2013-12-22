# -*- coding: utf-8 -*-
require 'socket'
# 新しいサーバ接続をポート10001で開く
server = TCPServer.open(3002)
texts = []
users = []
loop do
  Thread.start(server.accept) do |client|
    user_id = users.size
    users.push(["",0,0])
    loop do
      command = client.gets.chomp
      case command
      when "name"
        name = client.gets.chomp
        users[user_id][0] = name
        p name
      when "move"
        xy = client.gets.chomp.split(",")
        users[user_id][1] = xy[0]
        users[user_id][2] = xy[1]
        p xy
      when "text"
        texts.push(client.gets.chomp)
        texts.shift if(texts.size > 30)
        client.puts("#{texts}")
        p texts
      when "get"
        client.puts("#{texts}")
      end
      client.puts users.join(",")
    end
  end
end