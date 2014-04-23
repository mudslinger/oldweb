module RecruitReportSendable
  extend ActiveSupport::Concern

  def reported?
    self.sent
  end

  def report
    ses = AWS::SES::Base.new(access_key_id: ENV["SES_KEY"],secret_access_key: ENV["SES_SECRET"])

    to = ['saiyo@yamaokaya.com','tanaka@yamaokaya.com','sales-man@yamaokaya.com']
    to = to + [self.shop.mail_addrs[:sv],self.shop.mail_addrs[:group]] if self.work_style == 'パート・アルバイト'
    ses.send_email(
      :to        => to,
      :source    => 'recruit@yamaokaya.com',
      :subject   => "求人応募メールNo.#{self.id} (店舗:#{self.shop.name})",
      html_body: yield({type: :haml, locals: {body: self}, template: 'recruit/mail',layout: 'blank'})
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