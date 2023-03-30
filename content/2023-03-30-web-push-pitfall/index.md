+++
title = "Web Push Pitfall"
description = "Something they don't tend to tell you about implementing Web Push notifications..."

[extra]
embed_card_image = "/images/cards/hello-is-this-thing-on.png"
enable_comments = true
+++

Whilst implementing Web Push notifications for my toy Q&A service [curiouswolf](https://github.com/videah/curiouswolf)
I ran into an issue that led to me being stumped for hours. I was successfully receiving notifications from my server
when using Chrome, but no matter what Safari was not playing ball.

Web Push requires the browser maintainers to run a notification endpoint. For example, when you use Google Chrome and you enable
notifications on a page, your *encrypted* notifications get funneled through a server Google controls. In the case of
Safari however, their endpoint was returning `BadJwtToken` for me despite it being considered valid by Google.

## The Solution

It turns out that Apple (and Mozilla apparently) require you to include a `sub` claim in your JWT with a 
method of contact (such as an email) for them to consider it valid.

If you are providing an email, the `sub` claim should be prefixed with `mailto:`

```json
{
  "sub": "mailto:admin@example.com", // <-- The important part
  "aud": "https://web.push.apple.com",
  "exp": "1680135079"
}
```

The reasoning behind this is to provide the operator of the endpoint with a means of contacting you if there's an issue.
However, this technically goes against the Web Push spec, and it's frustrating that something like this isn't spelled
out clearly in Apple or Mozilla's technical documentation.

{% figure(src="rfc.png", link="https://datatracker.ietf.org/doc/html/draft-thomson-webpush-vapid#section-2.1") %}
Notice the emphasis on the word MAY

{% end %}

Apple quite regularly leave important information out of their docs for web APIs like this, but it's really messed
up that the only place Mozilla talk about this is in a [blog post from 2016.](https://blog.mozilla.org/services/2016/08/23/sending-vapid-identified-webpush-notifications-via-mozillas-push-service/)
