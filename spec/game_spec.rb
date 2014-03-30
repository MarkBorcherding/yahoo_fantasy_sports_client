require_relative '../lib/yahoo_fantasy_sports_client/game'

module YahooFantasySportsClient
  describe Game do

    describe 'for current logged in user' do
      let(:xml) {
<<xml
<?xml version="1.0" encoding="UTF-8"?>
<fantasy_content xml:lang="en-US" yahoo:uri="http://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1/games;game_keys=mlb" time="34.711122512817ms" copyright="Data provided by Yahoo! and STATS, LLC" refresh_rate="60" xmlns:yahoo="http://www.yahooapis.com/v1/base.rng" xmlns="http://fantasysports.yahooapis.com/fantasy/v2/base.rng">
 <users count="1">
  <user>
   <guid>XAJNUJMHSBKTMNQDHTRIM3D7AY</guid>
   <games count="1">
    <game>
     <game_key>328</game_key>
     <game_id>328</game_id>
     <name>Baseball</name>
     <code>mlb</code>
     <type>full</type>
     <url>http://baseball.fantasysports.yahoo.com/b1</url>
     <season>2014</season>
    </game>
   </games>
  </user>
 </users>
</fantasy_content>
<!-- fan1292.sports.bf1.yahoo.com compressed/chunked Sun Mar 30 14:35:11 PDT 2014 -->
xml
      }

      subject { Game.parse xml, single: true }

      its(:game_key) { should == 328 }
      its(:game_id) { should == 328 }
      its(:name) { should == "Baseball" }
      its(:code) { should == "mlb" }
      its(:type) { should == "full" }
      its(:url) { should == "http://baseball.fantasysports.yahoo.com/b1" }
      its(:season) { should == "2014" }
    end

  end
end
