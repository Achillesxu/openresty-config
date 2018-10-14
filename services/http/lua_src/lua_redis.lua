--
-- Created by IntelliJ IDEA.
-- User: achilles_xushy
-- Date: 2018/10/14
-- Time: 7:05 PM
-- To change this template use File | Settings | File Templates.
--
local cjson = require "cjson"
local redis = require "resty.redis"

-- return json data
ngx.header.content_type = "application/json;charset=UTF-8"

local red = redis:new()

red:set_timeout(1000)

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say(cjson.encode({status=500, msg=string.format("err is <%s>", err)}))
    return
end

local args, err = ngx.req.get_uri_args()
if err == "truncated" then
    ngx.say(cjson.encode({status=500, msg=string.format("err is <%s>", err)}))
    return
end

local res, err = red:get(args["key_name"])
if not res then
    ngx.say(cjson.encode({status=200, msg=string.format("err here is <%s>", err)}))
    return
end

if res == ngx.null then
    ngx.say(cjson.encode({status=200, msg=string.format("your key value dont exist")}))
    return
else
    ngx.say(cjson.encode({status=200, msg=string.format("your key value is <%s>", res)}))
    return
end
