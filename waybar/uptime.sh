#!/usr/bin/env bash
jq -cn --arg u "$(uptime -p)" '{text: ("󰅐 " + ($u | sub("^up ";""))), tooltip: $u}'
