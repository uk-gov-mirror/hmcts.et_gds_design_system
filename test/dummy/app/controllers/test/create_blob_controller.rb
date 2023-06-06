module Test
  class CreateBlobController < ApplicationController
    def html_error
      render html: '<body><h1>Internal Server Error</h1><p>Something bad went wrong</p></body>',
             status: :internal_server_error
    end
  end
end
