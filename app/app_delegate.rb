class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # TODO add a real test app
    doc = Wakizashi::XML("<li>HiHi</li>")
    puts "name: " + doc.xpath("li").first.to_s
 
    true
  end
end
