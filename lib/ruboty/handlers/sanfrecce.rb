require 'ruboty/sanfrecce/client'

module Ruboty
  module Handlers
    class Sanfrecce < Base
      on /next game/, name: 'next_game', description: '直近の試合取得する'
      on /last game/, name: 'last_game', description: '直近最後の試合を取得する'

      def next_game(message)
        message.reply(Ruboty::Sanfrecce::Client.new.next_game)
      end

      def last_game(message)
        message.reply(Ruboty::Sanfrecce::Client.new.last_game)
      end
    end
  end
end
