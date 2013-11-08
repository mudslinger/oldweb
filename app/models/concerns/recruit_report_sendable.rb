module RecruitReportSendable
  extend ActiveSupport::Concern

  def reported?
    self.sent
  end

  def report
    ses = AWS::SES::Base.new(
      :access_key_id => 'AKIAI2Q5IAVIWTLA2SKA',
      :secret_access_key => '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')
    html = yield
    ses.send_email(
      :to        => 'tanaka@yamaokaya.com',
      :source    => 'info@yamaokaya.com',
      :subject   => "求人応募メール(No:#{self.id} 店舗:#{self.shop.name})",
      html_body: html
    )
    self.sent = true
    self.save(validate: false)
  end

  def static_map
    StaticMap::Image.new(
      {
        size: '300x300',
        sensor: false,
        center: "#{self.zip} #{self.address}",
        markers: [
          {
            location: "#{self.zip} #{self.address}",
            color: "blue",
            label: "E"
          },
          {
            latitude: self.shop.lat,
            longitude: self.shop.lng,
            color: "red",
            label: "Y"
          }
        ],
        maptype: 'road',
        zoom: 13
      }
    )
  end
end