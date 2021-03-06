{ Disposable } = require 'atom'
path = require 'path'
fs = require 'fs'
latexSymbols = require('latex-symbols-list')

module.exports =
class Command extends Disposable
  constructor: (latex) ->
    @latex = latex
    @additionalSuggestions = []
    @items = {}
  provide: (prefix) ->
    suggestions = @predefinedCommands(prefix)
    if prefix.length > 0
      for item in @additionalSuggestions
        if item.displayText.indexOf(prefix) > -1
          item.replacementPrefix = prefix
          suggestions.push item
      suggestions.sort((a, b) ->
        if a.displayText.indexOf(prefix) isnt b.displayText.indexOf(prefix)
          return a.displayText.indexOf(prefix) - b.displayText.indexOf(prefix)
        else
          return b.counts - a.counts
      )
      return suggestions
    if !@latex.manager.findAll()
      return suggestions
    @additionalSuggestions = []

    editor = atom.workspace.getActivePaneItem()
    currentPath = editor?.buffer.file?.path
    currentContent = editor?.getText()
    if currentPath and currentContent
      if @latex.manager.isTexFile(currentPath)
        texItems = @getCommandsFromContent currentContent
        for key of texItems
          @items[key] = texItems[key] if not (key of @items)
    for key of @items
      for pkg of @suggestions
        if !(key of @suggestions[pkg])
          @additionalSuggestions.push @items[key]

    suggestions = suggestions.concat @additionalSuggestions
    suggestions.sort((a, b) ->
      return -1 if a.counts > b.counts
      return 1)
    suggestions.unshift(
      text: '\n'
      displayText: 'Press ENTER for new line.'
      chainComplete: false
      replacementPrefix: ''
      latexType: 'command')
    return suggestions

  predefinedCommands: (prefix) ->
    cwlfile = "/home/gluon/github/Atom-LaTeX/cwl/test.cwl"
    # console.log cwlfile
    if !fs.existsSync(cwlfile)
      return {}
    content = fs.readFileSync cwlfile, 'utf-8'
    # console.log content
    texItems = @getCommandsFromCwl(content)
    for key of texItems
      @items[key] = texItems[key] if not (key of @items)
    suggestions = []
    for env of @suggestions.latex
      item = @suggestions.latex[env]
      if prefix.length is 0 or env.indexOf(prefix) > -1
        item.replacementPrefix = prefix
        item.type = 'function'
        item.latexType = 'command'
        suggestions.push item
    # for symbol in latexSymbols
    #   if prefix.length is 0 or symbol.indexOf(prefix) > -1
    #     if symbol[0] isnt '\\'
    #       continue
    #     suggestions.push
    #       displayText: symbol.slice(1)
    #       snippet: symbol.slice(1)
    #       chainComplete: false
    #       replacementPrefix: prefix
    #       type: 'function'
    #       latexType: 'command'
    #       counts: 0
    return suggestions

  getCommands: (tex) ->
    if !fs.existsSync(tex)
      return {}
    content = fs.readFileSync tex, 'utf-8'
    texItems = @getCommandsFromContent(content)
    for key of texItems
      @items[key] = texItems[key] if not (key of @items)

  getCommandsFromCwl: (content) ->
    items = {}
    # catches up to six arguments
    itemReg = /(?:\\){1}((?!begin|end)([\w]+)(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?)/g
    loop
      result = itemReg.exec content
      break if !result?
      if not (result[1] of items)
        chainComplete = false
        snippet = result[2]
        display = result[2]
        number_of_param = 0
        if result[3]
          number_of_param += 1
          chainComplete = true
          display += "#{result[3]}#{result[4]}#{result[5]}"
          snippet += "#{result[3]}${#{number_of_param}:#{result[4]}}#{result[5]}"
          if result[7]
            number_of_param += 1
            chainComplete = true
            display += "#{result[6]}#{result[7]}#{result[8]}"
            snippet += "#{result[6]}${#{number_of_param}:#{result[7]}}#{result[8]}"
            if result[10]
              number_of_param += 1
              chainComplete = true
              display += "#{result[9]}#{result[10]}#{result[11]}"
              snippet += "#{result[9]}${#{number_of_param}:#{result[10]}}#{result[11]}"
              if result[13]
                number_of_param += 1
                chainComplete = true
                display += "#{result[12]}#{result[13]}#{result[14]}"
                snippet += "#{result[12]}${#{number_of_param}:#{result[13]}}#{result[14]}"
                if result[16]
                  number_of_param += 1
                  chainComplete = true
                  display += "#{result[15]}#{result[16]}#{result[17]}"
                  snippet += "#{result[15]}${#{number_of_param}:#{result[16]}}#{result[17]}"
                  if result[19]
                    number_of_param += 1
                    chainComplete = true
                    display += "#{result[18]}#{result[19]}#{result[20]}"
                    snippet += "#{result[18]}${#{number_of_param}:#{result[19]}}#{result[20]}"
        items[result[1]] =
          displayText: display
          snippet: snippet + "$#{number_of_param + 1}"
          type: 'function'
          latexType: 'command'
          chainComplete: chainComplete
          counts: 1
      else
        items[result[1]].counts += 1
          # catches up to six arguments
    # itemReg = /\\(begin{([\w]+)}(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(\\item)?)/g
    # loop
    #   result = itemReg.exec content
    #   break if !result?
    #   if not (result[1] of items)
    #     chainComplete = false
    #     snippet = "begin{" + result[2] + "}"
    #     display = "begin{" + result[2] + "}"
    #     number_of_param = 0
    #     item = ""
    #     if result[3]
    #       number_of_param += 1
    #       chainComplete = true
    #       display += "#{result[3]}#{result[4]}#{result[5]}"
    #       snippet += "#{result[3]}${#{number_of_param}:#{result[4]}}#{result[5]}"
    #       if result[7]
    #         number_of_param += 1
    #         chainComplete = true
    #         display += "#{result[6]}#{result[7]}#{result[8]}"
    #         snippet += "#{result[6]}${#{number_of_param}:#{result[7]}}#{result[8]}"
    #         if result[10]
    #           number_of_param += 1
    #           chainComplete = true
    #           display += "#{result[9]}#{result[10]}#{result[11]}"
    #           snippet += "#{result[9]}${#{number_of_param}:#{result[10]}}#{result[11]}"
    #           if result[13]
    #             number_of_param += 1
    #             chainComplete = true
    #             display += "#{result[12]}#{result[13]}#{result[14]}"
    #             snippet += "#{result[12]}${#{number_of_param}:#{result[13]}}#{result[14]}"
    #             if result[16]
    #               number_of_param += 1
    #               chainComplete = true
    #               display += "#{result[15]}#{result[16]}#{result[17]}"
    #               snippet += "#{result[15]}${#{number_of_param}:#{result[16]}}#{result[17]}"
    #               if result[19]
    #                 number_of_param += 1
    #                 chainComplete = true
    #                 display += "#{result[18]}#{result[19]}#{result[20]}"
    #                 snippet += "#{result[18]}${#{number_of_param}:#{result[19]}}#{result[20]}"
    #     if result[21]
    #       item = "\\\\item "
    #     items[result[1]] =
    #       displayText: display
    #       snippet: snippet + "\n\t" + item + "$#{number_of_param + 1}\n\\\\end{#{result[2]}}\n$#{number_of_param + 2}"
    #       type: 'function'
    #       latexType: 'environment'
    #       chainComplete: chainComplete
    #       counts: 1
    #   else
    #     items[result[1]].counts += 1
    newCommandReg = /\\(?:re|provide)?(?:new)?command(?:{)?\\(\w+)(?:})?(?:\[([0-9]+)\]{)?/g
    loop
      result = newCommandReg.exec content
      break if !result?
      if not (result[1] of items)
        args_snippet = ''
        args_display = ''
        chainComplete = false
        number_of_param = 0
        if result[2]
          number_of_param = parseInt(result[2],10)
          chainComplete = true
          args_snippet += "{$#{i}}" for i in [1 .. number_of_param]
          args_display += "{}" for i in [1 .. number_of_param]
        items[result[1]] =
          displayText: result[1] + args_display
          snippet: result[1] + args_snippet + "$#{number_of_param + 1}"
          type: 'function'
          latexType: 'command'
          chainComplete: chainComplete
          counts: 1
      else
        items[result[1]].counts += 1
    return items

  getCommandsFromContent: (content) ->
    items = {}
    # itemReg = /\\([a-zA-Z]+)({[^{}]*})?({[^{}]*})?({[^{}]*})?/g
    # loop
    #   result = itemReg.exec content
    #   break if !result?
    #   if not (result[1] of items)
    #     if result[2]
    #       chainComplete = true
    #       snippet = result[1] + '{$1}'
    #       if result[3]
    #         snippet += '{$2}'
    #         if result[4]
    #           snippet += '{$3}'
    #     else
    #       chainComplete = false
    #       snippet = result[1]
    #     items[result[1]] =
    #       displayText: result[1]
    #       snippet: snippet
    #       type: 'function'
    #       latexType: 'command'
    #       chainComplete: chainComplete
    #       counts: 1
    #   else
    #     items[result[1]].counts += 1
    #   # Parse custom user-defined commands with fixed number of parameters TODO: optional parameters
    newCommandReg = /\\(?:re|provide)?(?:new)?command(?:{)?\\(\w+)(?:})?(?:\[([0-9]+)\]{)?/g
    loop
      result = newCommandReg.exec content
      break if !result?
      if not (result[1] of items)
        args_snippet = ''
        args_display = ''
        chainComplete = false
        number_of_param = 0
        if result[2]
          number_of_param = parseInt(result[2],10)
          chainComplete = true
          args_snippet += "{$#{i}}" for i in [1 .. number_of_param]
          args_display += "{}" for i in [1 .. number_of_param]
        items[result[1]] =
          displayText: result[1] + args_display
          snippet: result[1] + args_snippet + "$#{number_of_param + 1}"
          type: 'function'
          latexType: 'command'
          chainComplete: chainComplete
          counts: 1
      else
        items[result[1]].counts += 1
    return items

  resetCommands: ->
    @items = {}

  suggestions:
    latex:
      begin:
        displayText: 'begin'
        snippet: 'begin{$1'
        chainComplete: true
      cite:
        displayText: 'cite'
        snippet: 'cite{$1}$2'
        chainComplete: true
      ref:
        displayText: 'ref'
        snippet: 'ref{$1}$2'
        chainComplete: true
      input:
        displayText: 'input'
        snippet: 'input{$1}$2'
        chainComplete: true
      include:
        displayText: 'include'
        snippet: 'include{$1}$2'
        chainComplete: true
      subfile:
        displayText: 'subfile'
        snippet: 'subfile{$1}$2'
        chainComplete: true
      includegraphics:
        displayText: 'includegraphics'
        snippet: 'includegraphics{$1}$2'
        chainComplete: true
