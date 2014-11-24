helpers = require './spec-helper'

describe "Panes", ->
  [editor, editorElement, vimState] = []

  beforeEach ->
    vimMode = atom.packages.loadPackage('vim-mode')
    vimMode.activateResources()

    helpers.getEditorElement (element) ->
      editorElement = element
      editor = editorElement.getModel()
      vimState = editorElement.vimState
      vimState.activateCommandMode()
      vimState.resetCommandMode()

  keydown = (key, options={}) ->
    options.element ?= editorElement
    helpers.keydown(key, options)

  describe "switch panes", ->
    beforeEach ->
      editor.setText("abcde\n")
      atom.workspaceView = {
        focusPaneViewOnRight: ->
        focusPaneViewOnLeft: ->
        focusPaneViewBelow: ->
        focusPaneViewAbove: ->
        getActivePaneItem: -> editor
        getActiveView: -> {element: editorElement}
      }

    describe "the ctrl-w l keybinding", ->
      beforeEach ->
        spyOn(atom.workspaceView, 'focusPaneViewOnRight')

      it "focuses the pane on the right", ->
        keydown('w', ctrl: true)
        keydown('l')

        expect(atom.workspaceView.focusPaneViewOnRight).toHaveBeenCalled()

    describe "the ctrl-w h keybinding", ->
      beforeEach ->
        spyOn(atom.workspaceView, 'focusPaneViewOnLeft')

      it "focuses the pane on the left", ->
        keydown('w', ctrl: true)
        keydown('h')

        expect(atom.workspaceView.focusPaneViewOnLeft).toHaveBeenCalled()

    describe "the ctrl-w j keybinding", ->
      beforeEach ->
        spyOn(atom.workspaceView, 'focusPaneViewBelow')

      it "focuses the pane on the below", ->
        keydown('w', ctrl: true)
        keydown('j')

        expect(atom.workspaceView.focusPaneViewBelow).toHaveBeenCalled()

    describe "the ctrl-w k keybinding", ->
      beforeEach ->
        spyOn(atom.workspaceView, 'focusPaneViewAbove')

      it "focuses the pane on the above", ->
        keydown('w', ctrl: true)
        keydown('k')

        expect(atom.workspaceView.focusPaneViewAbove).toHaveBeenCalled()
