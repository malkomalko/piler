
_  = require 'underscore'
_.mixin require 'underscore.string'

codeRegexp = /```([a-zA-Z]*)\ *([\s\S]*?)```/i

renderBlock = (type, code) ->
  "<pre class=\"lang-#{ type }\"><code>#{ code.trim() }</code></pre>"


###
Parser for syntax hilighted code blocks in Github Markdown.

Replaces following blocks

```javascript
console.log("Hello");
```

with valid html


###
module.exports = (markup, render=renderBlock) ->

  while match = markup.match codeRegexp
    [__, type, code] = match
    if type is "html"
      code = _.escapeHTML code
    markup = markup.replace codeRegexp, render type, code

  markup

