require 'dotenv'
require 'google/api_client'
require 'pp'

module Ruboty
  module Sanfrecce
    class Client

      def initialize
        load_env
        @client = Google::APIClient.new(:application_name => '')
        @client.authorization = Signet::OAuth2::Client.new(
          :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
          :audience => 'https://accounts.google.com/o/oauth2/token',
          :scope => 'https://www.googleapis.com/auth/calendar.readonly',
          :issuer => ENV['ISSUER'],
          :signing_key => key)

        @client.authorization.fetch_access_token!
      end

      def next_game
        items = request(DateTime.now, DateTime.now + 365)
        return get_game(items.first)
      end

      def last_game
        items = request(DateTime.now - 365, DateTime.now)
        return get_game(items.last)
      end

      private

      def key
        Google::APIClient::KeyUtils.load_from_pkcs12(ENV['FILE_NAME'], ENV['SECRET_KEY'])
      end

      def request(min, max)

        # イベント取得
        cal = @client.discovered_api('calendar', 'v3')
        params = {'calendarId' => ENV['CALENDAR_ID'],
                  'orderBy' => 'startTime',
                  'timeMax' => max,
                  'timeMin' => min,
                  'singleEvents' => 'True'}

        result = @client.execute(:api_method => cal.events.list,
                                :parameters => params)
        return result.data.items
      end

      def load_env
        Dotenv.load
      end

      def get_game(item)
        title = item.summary
        time = item.start.date
        unless time
          time = item.start.dateTime.strftime("%Y/%m/%d %H:%M")
        end

        return "#{title}, #{time} KICK OFF"
      end
    end
  end
end
