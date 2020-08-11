class ApplicationController < ActionController::Base
  
  # helloアクション
  def hello
    render html: "hello, world!"
  end

end
