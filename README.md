# urlp

### Parse URLs to a Property List or JSON

<br> 

## Installation:

### Step 1:
Ensure you have command line tools for Xcode installed
```bash
xcode-select --install
```
---

### Step 2:
Clone this repository
```bash
git clone https://github.com/Soliez/urlp.git
```
---
### Step 3:
Compile main.swift
```bash
cd urlp/urlp && swiftc main.swift -o urlp
```
---
### Step 4:
Add the following line to your shell profile (`~/.profile`)
```bash
alias urlp="path/to/urlp"
```
Replace `path/to/urlp` with the full path to the urlp executable on your computer

## Usage:
```bash
urlp [-plist | -json] <URL>
```
---
### Parsing a URL to a Property List
```bash
urlp -plist "https://user:pass@example.com:8080/path?query=item&foo=bar#fragment"
```

### Output
```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>fragment</key>
	<string>fragment</string>
	<key>host</key>
	<string>example.com</string>
	<key>password</key>
	<string>pass</string>
	<key>path</key>
	<string>/path</string>
	<key>port</key>
	<integer>8080</integer>
	<key>query</key>
	<string>query=item&amp;foo=bar</string>
	<key>queryItems</key>
	<array>
		<dict>
			<key>name</key>
			<string>query</string>
			<key>value</key>
			<string>item</string>
		</dict>
		<dict>
			<key>name</key>
			<string>foo</string>
			<key>value</key>
			<string>bar</string>
		</dict>
	</array>
	<key>scheme</key>
	<string>https</string>
	<key>user</key>
	<string>user</string>
</dict>
</plist>
```
---

### Parsing a URL to JSON
```bash
urlp -json "https://user:pass@example.com:8080/path?query=item&foo=bar#fragment"
```

### Output
```json
{
  "user" : "user",
  "path" : "\/path",
  "scheme" : "https",
  "host" : "example.com",
  "queryItems" : [
    {
      "name" : "query",
      "value" : "item"
    },
    {
      "value" : "bar",
      "name" : "foo"
    }
  ],
  "fragment" : "fragment",
  "query" : "query=item&foo=bar",
  "password" : "pass",
  "port" : 8080
}
```
---

## Demo
![Demonstration](media/demo.gif)