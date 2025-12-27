#!/bin/sh
urxvtd -q -o -f &
ssh-add /run/secrets/ssh_key/andesite_git 2>/dev/null || true
ssh-add /run/secrets/ssh_key/personal_git 2>/dev/null || true
