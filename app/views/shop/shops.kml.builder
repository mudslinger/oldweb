xml.instruct! :xml, :version=> '1.0', :encoding => 'UTF-8'
xml.kml :xmlns => 'http://www.opengis.net/kml/2.2' do
xml.Document do
  xml.Style(:id => "randomColorIcon") do
    xml.IconStyle do
      xml.colorMode "random"
      xml.scale 1
      xml.Icon do
        xml.href "http://maps.google.com/mapfiles/kml/pal3/icon21.png"
      end
    end
  end
  @shops.each do |s|
    xml.Placemark do
    xml.name s.name
    xml.styleUrl "#randomColorIcon"
    xml.description s.shop_hour
    xml.address s.address
    xml.phoneNumber s.phone
      xml.Point do
        xml.coordinates "#{s.lng},#{s.lat}"
      end
    end
  end
end
end
