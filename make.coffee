#!/usr/bin/env coffee
project = 'repo/react-todolist'

require 'shelljs/make'
path = require 'path'
mission = require 'mission'

mission.time()

target.folder = ->
  mission.tree
    '.gitignore': ''
    'README.md': ''
    js: {}
    build: {}
    cirru: {'index.cirru': ''}
    coffee: {'main.coffee': ''}
    css: {'style.css': ''}

target.coffee = ->
  mission.coffee
    find: /\.coffee$/, from: 'coffee/', to: 'js/', extname: '.js'
    options:
      bare: yes

cirru = (data) ->
  mission.cirruHtml
    file: 'index.cirru'
    from: 'cirru/'
    to: './'
    extname: '.html'
    data: data

browserify = (callback) ->
  mission.browserify
    file: 'main.js', from: 'js/', to: 'build/', done: callback

target.cirru = -> cirru inDev: yes
target.cirruBuild = -> cirru inBuild: yes
target.browserify = -> browserify()

target.compile = ->
  cirru inDev: yes
  target.coffee yes
  browserify()

target.build = ->
  cirru inBuild: yes
  target.coffee yes
  browserify()

target.watch = ->
  station = mission.reload()

  mission.watch
    files: ['cirru/', 'coffee/']
    trigger: (filepath, extname) ->
      switch extname
        when '.cirru'
          cirru()
          station.reload project
        when '.coffee'
          filepath = path.relative 'coffee/', filepath
          mission.coffee
            file: filepath, from: 'coffee/', to: 'js/', extname: '.js'
            options:
              bare: yes
          browserify ->
            station.reload project

target.patch = ->
  target.compile()
  mission.bump
    file: 'package.json'
    options:
      at: 'patch'

target.rsync = ->
  target.build()
  mission.rsync
    file: './'
    dest: 'tiye:~/repo/react-todolist'
    options:
      exclude: [
        'node_modules/'
        'bower_components/'
        'coffee'
        'README.md'
        'js'
        '.git/'
        'png/*.jpg'
      ]