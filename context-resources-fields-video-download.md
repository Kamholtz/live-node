## Context 

mix phx.gen.live VideoDownload

## Resources

---
_Represents a url which contains a video to be downloaded_

Video videos 
title:string
url:string 
status:enum
duration_msecs:int

- [ ] how long?

The supported types are: 
- array
- binary
- boolean
- date
- decimal
- enum
- float
- integer
- map
- naive_datetime
- naive_datetime_usec
- references
- string
- text
- time
- time_usec
- utc_datetime
- utc_datetime_usec
- uuid

```bash
mix phx.gen.live VideoDownload Video videos title:string url:string duration_msecs:integer status:enum:in_progress:success:error
```

---
