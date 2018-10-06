--
-- Created by IntelliJ IDEA.
-- User: achilles_xushy
-- Date: 2017/12/22
-- Time: 下午5:04
-- To change this template use File | Settings | File Templates.
-- from ssdb get nan_gua_media_info_hash
local json = require "cjson"
local ssdb = require "resty.ssdb"

ngx.header.content_type = "application/json;charset=UTF-8"

local hash_name = ngx.var['arg_hash_name']
local key_name = ngx.var['arg_key_name']

if hash_name == nil then
    ngx.say(json.encode({status=400, msg="缺少合法参数"}))
    return
end

local db = ssdb:new()
db:settimeout(1000)

local ok, err = db:connect("127.0.0.1", 8886)

if not ok then
    ngx.say("failed to connect: ", err)
    return
end

local cnt = db:hsize(hash_name)

if cnt then
    if key_name == nil then
        local my_table = {}
        local ret = db:hscan(hash_name, '', '', cnt)
        for z, k in pairs(ret) do
            for i, j in pairs(k) do
                my_table[i] = json.decode(j)
            end
        end
        ngx.say(json.encode(my_table))
    else
        local ret = db:hget(hash_name, key_name)
        if ret then
            ngx.say(ret)
        else
            ngx.say({status=200, msg=string.format("%s not exist in %s", key_name, hash_name)})
        end
    end
else
    ngx.say(json.encode({status=400, msg="hash name dont exist", hash_name=hash_name, cnt=db:hsize(hash_name)}))
end







