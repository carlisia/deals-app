# Deals App

A sample app that imports a file and persists data it into multiple data models using transaction control. Includes OpenId.

## Highlights

This app imports a file and persists its data it into multiple data models.

### A File Layout determines valid data
A layout is used to determine what data is valid to import. Not implemented at this time, but different file layouts can be easily added to allow for different data sets to be imported. For example, a file could contain only Purchaser and/or Merchant data if a file layout for either or both of those models was selected. This is possible because the models are created in modules, and the validations happen against a given file layout. Also, with this design, the columns will be accepted with any header name, because the layout only takes into account the position of the data. An improvement in this code area would be to extract the layout into its own class.

### Transaction Control
This implementation uses transaction control and successfully rows everything back if any row is invalid, informing the user with an alert message of in what row in the file the invalid data resides and what it is. This keeps the database clean of any potentially dirty data. Two steps for improvement in this area of the code would be:

- to continue processing an x number of records, 50 for example, so if there were more rows with errors the users wouldn't get them one by one, and,
- to use bulk insert for better performance and scalability.

### Import Report
After a file is imported with purchase data, the user is shown a Report listing metadata for the importation: name of the file, number of records imported, total gross amount for all purchases imported, and date and time of import. There is also a listing for all reports imported.

### OpenID
An authentication with any OpenID service is used. An improvement in this area would be to accept authentication using specific services when it becomes a requirement.

### Tests
Acceptance tests pass for all feature requirements. More unit test coverage should be added.

## Setup
View all the instructions for setup in the [Documentation Section](README.rdoc).

## About the Code

### OO Rules

This project attempts to follow Sandi Metz's [4 Rules for Developers](http://robots.thoughtbot.com/post/50655960596/sandi-metz-rules-for-developers).

### No objects that end with 'er'.

I confess: Naming objects that ended in 'er' had been part of my or my repertoire since I began to code. Thanks to [@staskie](http://github.com/staskie), I've been shown a new way and am starting to experiment with it in this project.

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

I use the ["Weirich convention"](http://onestepback.org/index.cgi/Tech/Ruby/BraceVsDoEnd.rdoc) for choosing between {} and do...end delimiters around blocks. Thanks to [@avdi](http://github.com/avdi) for tipping me to this.