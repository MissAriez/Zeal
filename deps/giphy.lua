local class = require 'class'
local Array = require 'Array'
local request = require 'request'

return class {
  constructor = function(self, api_key)
    self.api_key = api_key
  end;
  search = function(self, query)
    local url = ('http://api.giphy.com/v1/gifs/search?q=%s&api_key=%s'):format(Array(query:split ' '):join '+', self.api_key)
    return request {
      url = url;
    }:next(function(res)
      res = res[1]
      local gif = table.random(res.data)
      return gif.url
    end):await()[1]
  end;
}