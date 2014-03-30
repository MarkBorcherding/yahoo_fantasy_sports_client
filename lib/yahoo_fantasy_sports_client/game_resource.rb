module YahooFantasySportsClient
  module GameResource

    def self.access_token=(value)
      @@access_token = value
    end

    def self.access_token
      @@access_token
    end

    def self.get(url)

    end

    def self.all_for_current_user

    end
  end
end
