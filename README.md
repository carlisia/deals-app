# Deals App

A sample app that manages the import of data and persistence into multiple data models.

## Setup
[Documentation](README.rdoc)## About the Code

### OO Rules

This project attempts to follow Sandi Metz's [4 Rules for Developers](http://robots.thoughtbot.com/post/50655960596/sandi-metz-rules-for-developers).

### No objects that end with 'er'.

I confess: Naming objects that ended in 'er' had been part of my or my repertoir since I began to code. Thanks to [@staskie](github.com/staskie), I've been shown a new way and am starting to experiment with it in this project.

This is the reason why:

> We want to create objects that describe what they are, and then bind behavior to them,
> rather than focus on what they do, and then figure out what data they'll need to do that.

Source: [Travis Griggs](http://objology.blogspot.com/2011/09/one-of-best-bits-of-programming-advice.html)

Example:

FileImporter: Focus is on what the object does, which sounds like it is to import a file. One big problem is that it sounds very generic and yet the code is probably supposed to be very specific.

Instead:

PurchaseFile: Now I immediately get to start thinking about what to do with a file that has purchase data.

Another good read: [Carlo Pescio](http://www.carlopescio.com/2011/04/your-coding-conventions-are-hurting-you.html)

### Weirich convention

I use the ["Weirich convention"](http://onestepback.org/index.cgi/Tech/Ruby/BraceVsDoEnd.rdoc) for choosing between {} and do...end delimiters around blocks. So blocks which are evaluated for their result value, I surround with braces ({}); whereas blocks which are evaluated for their side-effects get do...end.

Thanks to [@avdi](github.com/avdi) for tipping me to this.

## Tests



