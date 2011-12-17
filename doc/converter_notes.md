# Open Office Converter

`unoconv -f html -d document <file>`

* It detects bold and italics okay. 
* Should probbaly nuke newlines. Open Office wraps the text :|
* Headings seems to be autodetected and are unrelaible. Seen <DIV TYPE=HEADER> and <H1>
* Autonumbers look like: <SDFIELD TYPE=PAGE SUBTYPE=RANDOM FORMAT=PAGE>7</SDFIELD>
* Headers appear in a normal tag with the text: "Running head:"


# Strategy

- Do a preparse with a lenient sanitizer to remove font tags.
- Use nokogiri 
  - collapse multiple empty paragraphs 
  - convert left indented paragraphs to block quotes.
- Do a second sanitizer pass to remove all style information.

