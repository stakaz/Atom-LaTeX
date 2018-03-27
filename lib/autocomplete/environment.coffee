{ Disposable } = require 'atom'
path = require 'path'
fs = require 'fs'

module.exports =
class Environment extends Disposable
  constructor: (latex) ->
    @latex = latex
    @additionalSuggestions = []
    @items = {}
  # provide: (prefix) ->
  #   cwlfile = "/home/gluon/github/Atom-LaTeX/cwl/test.cwl"
  #   # console.log cwlfile
  #   if !fs.existsSync(cwlfile)
  #     return {}
  #   content = fs.readFileSync cwlfile, 'utf-8'
  #   # console.log content
  #   texItems = @getCommandsFromCwl(content)
  #   console.log texItems
  #   for key of texItems
  #     @items[key] = texItems[key] if not (key of @items)
  #   suggestions = []
  #   for key of @items
  #   # for env of @suggestions.latex
  #     # item = @suggestions.latex[env]
  #     # if prefix.length is 0 or env.indexOf(prefix) > -1
  #     @items[key].replacementPrefix = "\\\\begin{" + prefix
  #     # suggestions.push item
  #     suggestions.push @items[key]
  #     console.log @items[key]
  #   suggestions.sort((a, b) ->
  #     return -1 if a.text < b.text
  #     return 1)
  #   console.log(suggestions)
  #   return suggestions
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

    # editor = atom.workspace.getActivePaneItem()
    # currentPath = editor?.buffer.file?.path
    # currentContent = editor?.getText()
    # if currentPath and currentContent
    #   if @latex.manager.isTexFile(currentPath)
    #     texItems = @getCommandsFromContent currentContent
    # for key of texItems
      # @items[key] = texItems[key] if not (key of @items)
    for key of @items
      # for pkg of @suggestions
      @items[key].replacementPrefix = prefix
      @additionalSuggestions.push @items[key]
    # console.log suggestions
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
    console.log texItems
    for key of texItems
      @items[key] = texItems[key] if not (key of @items)
    suggestions = []
    # for env of @suggestions.latex
    #   item = @suggestions.latex[env]
    #   if prefix.length is 0 or env.indexOf(prefix) > -1
    #     item.replacementPrefix = prefix
    #     item.type = 'function'
    #     item.latexType = 'command'
    #     suggestions.push item
    # # for symbol in latexSymbols
    # #   if prefix.length is 0 or symbol.indexOf(prefix) > -1
    # #     if symbol[0] isnt '\\'
    # #       continue
    # #     suggestions.push
    # #       displayText: symbol.slice(1)
    # #       snippet: symbol.slice(1)
    # #       chainComplete: false
    # #       replacementPrefix: prefix
    # #       type: 'function'
    # #       latexType: 'command'
    # #       counts: 0
    # console.log suggestions
    return suggestions


  getCommandsFromCwl: (content) ->
    items = {}
    # catches up to six arguments
    itemReg = /\\begin({([\w]+)}(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(?:([{\[\<]{1,2})([\w\s-\+\*]*)([}\]\>]{1,2}))?(\\item)?)/g
    loop
      result = itemReg.exec content
      break if !result?
      itemname = result[1]
      if not (itemname of items)
        chainComplete = false
        snippet = result[2] + "}"
        display = "begin{" + result[2] + "}"
        number_of_param = 0
        item = ""
        if result[4]
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
        if result[21]
          item = "\\\\item "
        items[itemname] =
          replacementPrefix: ''
          displayText: display
          snippet: snippet + "\n\t" + item + "$#{number_of_param + 1}\n\\\\end{#{result[2]}}\n$#{number_of_param + 2}"
          type: 'function'
          latexType: 'environment'
          chainComplete: chainComplete
          counts: 1
      else
        items[itemname].counts += 1
    return items

  suggestions:
    latex:
      figure:
        text: 'figure'
        additionalInsert: '\\caption{title}'
    #   table:
    #     text: 'table'
    #     additionalInsert: '\\caption{title}'
    #   description:
    #     text: 'description'
    #     additionalInsert: '\\item [label] '
    #   enumerate:
    #     text: 'enumerate'
    #     additionalInsert: '\\item '
    #   itemize:
    #     text: 'itemize'
    #     additionalInsert: '\\item '
    #   math:
    #     text: 'math'
    #   displaymath:
    #     text: 'displaymath'
    #   split:
    #     text: 'split'
    #   array:
    #     text: 'array'
    #   eqnarray:
    #     text: 'eqnarray'
    #   equation:
    #     text: 'equation'
    #   equationAst:
    #     text: 'equation*'
    #   subequations:
    #     text: 'subequations'
    #   subequationsAst:
    #     text: 'subequations*'
    #   multiline:
    #     text: 'multiline'
    #   multilineAst:
    #     text: 'multiline*'
    #   gather:
    #     text: 'gather'
    #   gatherAst:
    #     text: 'gather*'
    #   align:
    #     text: 'align'
    #   alignAst:
    #     text: 'align*'
    #   alignat:
    #     text: 'alignat'
    #   alignatAst:
    #     text: 'alignat*'
    #   flalign:
    #     text: 'flalign'
    #   flalignAst:
    #     text: 'flalign*'
    #   theorem:
    #     text: 'theorem'
    #   cases:
    #     text: 'cases'
    #   center:
    #     text: 'center'
    #   flushleft:
    #     text: 'flushleft'
    #   flushright:
    #     text: 'flushright'
    #   minipage:
    #     text: 'minipage'
    #   quotation:
    #     text: 'quotation'
    #   quote:
    #     text: 'quote'
    #   verbatim:
    #     text: 'verbatim'
    #   verse:
    #     text: 'verse'
    #   picture:
    #     text: 'picture'
    #   tabbing:
    #     text: 'tabbing'
    #   tabular:
    #     text: 'tabular'
    #   thebibliography:
    #     text: 'thebibliography'
    #   titlepage:
    #     text: 'titlepage'
    #   frame:
    #     text: 'frame'
