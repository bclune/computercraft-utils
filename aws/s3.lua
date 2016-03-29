os.loadAPI('/src/realtime/realtime.lua')
os.loadAPI('/src/lib/sha256.lua')
local S3_KEY = fs.open('/etc/s3/key', 'r').readLine()
local S3_SECRET = fs.open('/etc/s3/secret', 'r').readLine()

function uploadJson(payload, bucket, s3_path, s3_filename)
    local uri = 'http://' .. bucket .. '.s3.amazonaws.com' .. s3_path .. s3_filename
    local date = realtime.getUtcTime()
    local content_type = 'application/json'
    local string = 'PUT\n\n' .. content_type .. date .. acl .. bucket .. s3_path .. s3_filename
    local signature = sha256.hmac(string, S3_SECRET)
    local headers = {
        [ "Host" ] = bucket .. '.s3.amazonaws.com',
        [ "Date" ] = date,
        [ "Content-Type" ] = content_type,
        [ "x-amz-acl" ] = 'public-read',
        [ "Authorization" ] = 'AWS ' .. S3_KEY .. ':' .. signature
    }

    http.post(uri, payload, headers)
end