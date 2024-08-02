+++
title = "Howdy, Is This Thing On?"
description = "Since things are uh... collapsing? I thought it'd be a good idea to finally get my blog up and running."

[extra]
image_label = "Some art from [@mollowmollow](https://twitter.com/mollowmollow)"
image_alt = "my fursona panicking in front of a laptop surrounded by fire with text saying 'oh no' above"
image_ratio = 3
enable_comments = true
unlisted = false
nsfw = false
show_image_on_index = true
+++

Since things are uh... [collapsing](https://www.theguardian.com/technology/2022/nov/12/elon-musk-twitter-chaos-enleashed)?
I thought it'd be a good idea to finally get my blog up and running. Come in, get comfy and take a look around!
Cozy right?

### Getting Started (Again)
Ok admittedly, this is my 4th attempt at making a blog. This time I'm using [Zola](https://www.getzola.org) which 
is like [Hugo](https://gohugo.io) or [Jekyll](https://jekyllrb.com) but more Rust-y and less JavaScript-y. I can't 
make any comparisons beyond that because I haven't used either, but my initial impressions of Zola are good! The theme 
you're looking at I made from scratch using [Tailwind](https://tailwindcss.com) which is the only way I can do 
frontend web stuff now.

I wanted to move away from what I had been using in the past ([Ghost](https://ghost.org)) and have my blog sit in a 
git repo in plain text instead. How I currently have things set up means when I push
any changes to the blog's [GitHub](https://github.com/videah/blog) repo an action runner will automatically build my
site (in about 17ms!), compile [Caddy](https://caddyserver.com), embed the site into the binary 
using [caddy-embed](https://github.com/mholt/caddy-embed) (in... a lot more than 17ms!), then finally push it as an 
image to DockerHub. My server will then see this new image, hot-swap it, and start serving my blog straight from memory!

### Little Gremlin
{% sonavisible() %}
I hope you like my little [rantsona](https://knowyourmeme.com/memes/rantsona) in the sidebar! He took the longest 
to get working out of everything if you can believe it. I can disable him on a per-article basis, you don't have to 
worry about him 🤔-ing the more serious posts.
{% end %}

{% sonainvisible() %}
You can't see him unfortunately (try looking at this page on a larger screen) but I hope you like my little 
[rantsona](https://knowyourmeme.com/memes/rantsona) in the sidebar! He took the longest to get working out of 
everything if you can believe it. I can disable him on a per-article basis, you don't have to worry about him 🤔-ing 
the more serious posts.
{% end %}