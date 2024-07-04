+++
title = "My E-Reader Setup"
description = "A bundle of notes on the over-engineered way I read books now."

[extra]
embed_card_image = "/images/cards/e-reader.png"
image = "/images/banners/e-reader.png"
image_alt = "A Kobo Libra 2 e-reader sitting on some grass with my fursona on the screen saying 'Howdy!'"
image_ratio = 3
show_image_on_index = true
enable_comments = true
+++

I bought an e-reader recently, specifically the [Kobo Libra 2](https://uk.kobobooks.com/products/kobo-libra-2). I felt like I wasn't reading books/manga as much as I wanted and I think the convenience of being able to carry my entire library around with me will help with that. I own an iPad Pro but I wanted a device I didn't need to think about charging that often and wouldn't give me eye strain.

This post is a bundle of notes about my current reading setup.

{% callout(type="sleeping", side="left") %}
I had owned a Kindle Paperwhite before but it was so locked down that I couldn't find any joy out of using it since I was forced to use it how Amazon product managers wanted me to.
{% end %}

## The Libra 2
I spent several hours doing research and I think the Libra 2 is the best device on the market at the moment, at least for my needs.

I picked it up in white to try and make an important psychological distiction. I wanted it to differ from every other electronic rectangle I own and treat it more like a nice book rather than a computer that will inevitably make me angry. Which all things considered is quite funny with all the computer nonsense I ended up doing to it.

It's got a 7-inch screen which is a little shy of the perfect [Tankōbon volume](https://en.wikipedia.org/wiki/Tank%C5%8Dbon) size, but close enough that manga is comfortable to read. I remember reading somewhere that the screen has one of the best contrast ratios in an e-reader and it is indeed very good.

{% figure(src="images/uzumaki.jpg") %}
    The lineart of Junji Ito's Uzumaki looks very crisp on this display.
{% end %}

Navigation buttons are a dying breed in the e-reader space but I really can't live without them. Using a touchscreen to navigate is *hateful* and is really fake skeumorphism. You can pretend all you want but it does not feel like you are flipping a page! Thankfully the Libra 2 has two buttons on the side where you hold it so you can go back and forth with just one hand.

I got the very overpriced official [SleepCover](https://uk.kobobooks.com/products/kobo-libra-2-sleepcover) case in orange. Matches my iPad case. Stops the plastic from making flexing sounds. It can let your e-reader stand upright for some reason.

## Book Management
The only real book management software in town for e-readers is [Calibre](https://calibre-ebook.com) but it's stuck in the late 2000's UNIX school of UI design and I reaaally don't want to deal with that kind of thing anymore. I want organising my books to feel comfy. I also don't want it to depend on having my laptop with me, constantly wiring it to my e-reader to sync new books.

{% figure(src="images/calibre.png") %}
    Calibre on macOS. It is very noisy.
{% end %}

It's not perfect but [Calibre-Web](https://github.com/janeczku/calibre-web) works better for me. Despite the confusing name it's a completely distinct project that just happens to be compatible with Calibre's database format. I have it hosted on my personal VPS so I can access it anywhere and can give friends access if I need to. It's not quite Plex for books but it is close. The bootstrap UI is a little dated but it works for what I need.

{% callout(type="walking", side="left") %}
I'm keeping my eye on a relatively new project called [Librum](https://github.com/Librum-Reader/Librum) that's in its infancy. If it matures it promises some nice features like syncing reading positions and its own dedicated client.
{% end %}

## Reader Software
The default reader software the Libra 2 comes with is called Nickel and it's fine. It looks and runs ok enough and the built in Kobo Sync functionality can be tweaked to work with my Calibre-Web instance by replacing the endpoint in a config file, which I have to give Rakuten props for letting you do.

But sideloaded files can be very broken. I was half way through a book before I realised Nickel was just throwing all of my notes and highlights into the void whenever I closed it, which was very rude. This is apparently a common problem that's been around for a while and it seems Rakuten have no plan to fix it anytime soon.

I went looking around for some open source alternatives. Most people reach for [KOReader](https://koreader.rocks). It runs on pretty much everything and is packed with an ungodly amount of features and has a steady community built around it.

{% figure(src="images/ereader_ui.png") %}
Comparing library views for KOReader and Plato.
{% end %}

But if I'm being honest I just can't find any enjoyment using it. The user interface just isn't up to snuff. It feels impossible to navigate and there is no real library view, only a file manager. When I'm holding my e-reader I don't want to be reminded that it is a computer all the time. It's meant to be a book!

I came across [Plato](https://github.com/baskerville/plato) which is made exclusively for Kobo devices and worked on by the guy responsible for bspwm. It's really fast and responsive, more so than Nickel even. The UI is pretty much exactly what I'm looking for. It's not nearly as feature complete as KOReader but it's written in Rust which is a language I feel confident enough in to tweak and implement things to my hearts desire. [I've already made a small change that got merged upstream too!](https://github.com/baskerville/plato/pull/323)

## Syncing
Originally I was using Kobo Sync with the endpoint changed to point to my Calibre-Web instance to sync my books wirelessly. But it was buggy and slow and could only pull in KEPUB files.

Plato has a built in [hook system](https://github.com/baskerville/plato/blob/master/doc/HOOKS.md) that lets you run arbitrary binaries when a directory is opened. Using this I wrote a small CLI tool that just pulls every book that hasn't been downloaded yet from my Calibre-Web instance using the [OPDS protocol](https://en.wikipedia.org/wiki/Open_Publication_Distribution_System).

{% callout(type="love", side="left") %}
I've stuck the code for this tool up on [my Github](https://github.com/videah/plato-opds) if anyone else is interested in using it!
{% end %}

In the future I would like to take advantage of this hook system to also sync reading positions and other metadata Plato stores.

## Tailscale VPN
I love plugging as many of my devices into my Tailscale network as I can and I thought it'd be a fun little project to try and get it running on the Libra 2. Someone had already done most of the work by [getting it to run on the Kobo Sage](https://dstaley.com/posts/tailscale-on-kobo-sage).

It turns out it's a little harder for the Libra, I had to spend a ridiculous amount of time compiling some missing kernel modules in a horrendously slow emulated x86 emulator just to get this thing running. The joys of owning an ARM laptop. I think being able to type `ping kobo` and have it Just Work makes all the hours spent worthwhile though ☺️

{% callout(type="love", side="left") %}
I packaged all the work I done up nicely in an [install script](https://github.com/videah/kobo-tailscale) so it should be dead easy to get this working on your Libra 2 as well.
{% end %}

Tailscale has a built in [AirDrop-esque file transfer feature](https://tailscale.com/kb/1106/taildrop) that I find really useful for quickly sending PDFs to my e-reader that I don't necessarily want to be a permanent part of my library.

{% figure(src="images/taildrop.png") %}
    Sending a PDF remotely with one click with TailDrop.
{% end %}

Unfortunately I couldn't get Tailscale SSH working which was one of the main reasons I attempted this in the first place 😢 I'm not sure why but my first guess would be that I need iptable packet filtering but that would require swapping out the whole kernel which I don't feel comfortable doing at the moment. Maybe some day though.

## SSH
The Libra 2 only has telnet support out of the box behind a developer cheat code (typing devmodeon into the search bar) which is fine because I'd be using it over a Tailscale wireguard connection anyway. My threat model doesn't exactly involve people bruteforcing telnet over public WiFi just to steal my furry books. But for completions sake I stuck the [Dropbear SSH server](https://matt.ucc.asn.au/dropbear/dropbear.html) on mine and then disabled telnet.

## Storage
The Libra 2 has 32gb of internal storage which is pretty huge for books considering how small EPUBs usually are. But I like reading manga which can be pretty hefty. An average volume is 200mb, with stuff like Uzumaki coming in at 800mb. What if I need to store every uncompressed volume of One Piece for offline reading in the event of the apocalypse?

Most e-readers treat manga as secondary to books and rarely offer higher storage options or mini-SD card slots anymore. Thankfully the Libra 2 has a mini-SD slot... it's just an internal one not meant to be user accessable 🫠

{% figure(src="images/libra2_internals.png") %}
Libra 2 internals, SD card highlighted in the red circle. <br> Image taken by [MobileRead user 'supermighty'](https://www.mobileread.com/forums/showthread.php?t=342428)
{% end %}

This is better than not being able to upgrade the storage at all though and was actually one of the main things that pushed me in the Libra 2's direction when doing research. Someone on the MobileRead forums [replaced the SD card and posted instructions on how to do so.](https://www.mobileread.com/forums/showthread.php?t=348546)

I haven't done this for mine yet but I plan on giving it a shot and sticking something utterly ridiculous like 512gb or 1tb in there. It seems like a pretty risky/messy mod to do though, the slot and card are caked in waterproofing glue that you'll need to reapply afterwards if you're like me and enjoy reading in the bath.

Even if this seems excessive it does let me sleep easier at night knowing I can replace the internal storage in the event it somehow fries itself.

## Dictionary
This is a feature I didn't know I wanted till I used it. It's a pretty big leg-up over reading physical books when I can easily hold down on a word I'm not sure about.

I'm using the [ebook-reader-dict](https://github.com/BoboTiG/ebook-reader-dict) project which is based on Wiktionary since that's the one Plato recommends and is designed to work with. Unfortunately it's a bit hit or miss. I'm not too happy about the quality of the definitions sometimes, I'll probably look at alternatives at some point.

{% callout(type="normal", side="left") %}
Plato renders the definitions without any padding which looks a bit weird. I can probably fix this easily in the code later though. Feels good using open source software sometimes.
{% end %}

## Font
For reading, I use the font [Atkinson Hyperlegible](https://brailleinstitute.org/freefont) which you might know from [Cohost](https://cohost.org), but it's also used by the very blog you're looking at now! I've fallen in love with it as it's really easy to read even when the text is very small. Very pretty and accessible.