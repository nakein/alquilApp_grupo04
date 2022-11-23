class ApplicationController < ActionController::Base
    protect_from_forgery except: :sign_in

    def set_cache_headers
        response.headers["Cache-Control"] = "no-cache, no-store"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
      end
end
