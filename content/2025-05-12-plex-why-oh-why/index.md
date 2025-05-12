+++
title = "Plex Might Be Indavertently Bottlenecking You"
description = "How it took several months for me to get warm..."

[extra]
show_banner_on_index = false
enable_comments = true
+++

Plex has this [Relay feature](https://support.plex.tv/articles/216766168-accessing-a-server-through-relay) that basically
pipes your traffic through their servers if direct access isn't possible for whatever reason, bypassing NAT and 
presumably cutting down on their support tickets.

For free users the relay is capped at a measly `1 Mbps` and the [ever-growing expense that is the [Plex Pass subscription](https://www.plex.tv/plans)
service only bumps this up to a whopping `2 Mbps`.

I can imagine this being useful for a selection of people. But as this feature is turned on **by default**, it's very easy for any
issues with your server's network configuration to go unnoticed. It turns out my port-forwarding rule for Plex hadn't been working
for several months (*thanks Ubiquiti*) and I never noticed because the relay feature was masking the problem.

{% callout(type="dead", side="right") %}
So... you're telling me Plex isn't meant to be almost unusably slow this whole time...?
{% end %}

It doesn't help that the remote-access configuration UI has been very buggy for 6+ years, making it
impossible to tell if the issue is with your server or the broken interface.

So please don't make the same mistakes as me. Make sure your Plex client is actually connecting to your server directly, and use a [Port Forward Checker](https://www.yougetsignal.com/tools/open-ports).