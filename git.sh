#!/bin/bash
git init
git add *
git commit -m "Only one version"
git branch -M main
git remote add origin git@github.com:Evilcat0/wtf-game-ruby.git
git push -u origin main
